class GamblesController < ApplicationController
  respond_to :js
  # GET /gambles
  # GET /gambles.json
  def index
    @active_gambles = Gamble.find_all_user_gamble4_last_round(params[:page])
        
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @gambles }
    end
  end

  # GET /gambles/1
  # GET /gambles/1.json
  def show
    @gamble = Gamble.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gamble }
    end
  end

  # GET /gambles/new
  # GET /gambles/new.json
  def new
    @gamble = Gamble.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gamble }
    end
  end

  # GET /gambles/1/edit
  def edit
    @gamble = Gamble.find(params[:id])
  end

  # POST /gambles
  # POST /gambles.json
  def create
     @match = Match.find(params[:match_id])
     @gamble = Gamble.new(params[:gamble])
     @gamble.match = @match
     @gamble.user = current_user
     #@gamble = Gamble.create_gamble4_user(@gamble, current_user)    
     respond_to do |format|
       unless ((ApplicationHelper.get_utc_time) >= (@match.date_match - 2.hours))
         if @gamble.save
           @gamble4_current_match = current_user.gambles.joins(:match).where("matches.id = ?",[@match.id])
           @gamble = (@gamble4_current_match.present?)? @gamble4_current_match.first : nil
           flash[:notice] = "A aposta esta feita Giow!"
         else
             @gamble4_current_match = current_user.gambles.joins(:match).where("matches.id = ?",[@match.id])
         end
       else
          flash[:notice] = "Nao foi possivel realizar sua aposta, tempo limite excedido!"
       end
       format.js               
     end
  end

  # PUT /gambles/1
  # PUT /gambles/1.json
  def update
    @gamble = Gamble.find(params[:id])

    respond_to do |format|
      if @gamble.update_attributes(params[:gamble])
        format.html { redirect_to @gamble, notice: 'Gamble was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @gamble.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gambles/1
  # DELETE /gambles/1.json
  def destroy
    @gamble = Gamble.find(params[:id])
    @match = @gamble.match
    unless ((ApplicationHelper.get_utc_time) >= (@match.date_match - 2.hours))
      if @gamble.destroy
  	     @gamble = Gamble.new
         @gamble4_current_match = nil
         flash[:notice] = "Sua aposta foi cancelada!"
       end
    else
       flash[:notice] = "Nao foi possivel excluir sua aposta, tempo limite excedido!"
    end   	
    respond_to do |format|
     # format.html { redirect_to gambles_url }
      #format.json { head :no_content }
  	 format.js 
    end
	end
	
  def active_gambles
    @active_gambles = Gamble.active_gambles
  end  
end
