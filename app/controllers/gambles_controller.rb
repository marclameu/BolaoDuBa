class GamblesController < ApplicationController
  respond_to :js
  # GET /gambles
  # GET /gambles.json
  def index
    @gambles = Gamble.find(:all).paginate(:page => params[:page], :per_page => 4)
        
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
    @gamble = Gamble.new(params[:gamble])
	  @match = Match.find(params[:match_id])
    @gamble.match = @match
    @gamble = Gamble.create_gamble4_user(@gamble, current_user)

    respond_to do |format|
      if @gamble.save
        #format.html { redirect_to @gamble, notice: 'Gamble was successfully created.' }
        #format.json { render json: @gamble, status: :created, location: @gamble }
		    @gamble4_current_match = current_user.gambles.joins(:match).where("matches.id = ?",[@match.id])
		    @gamble = (@gamble4_current_match.present?)? @gamble4_current_match.first : nil
    #        @gambles = Gamble.find_all_user_gambles(current_user, params[:page])
        flash[:notice] = "A aposta esta feita Giow!"
        format.js
      else
        #format.html { render action: "new" }
        #format.json { render json: @gamble.errors, status: :unprocessable_entity }
		    @gamble4_current_match = current_user.gambles.joins(:match).where("matches.id = ?",[@match.id])
        format.js
      end
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
    if @gamble.destroy
	  @gamble = Gamble.new
      @gamble4_current_match = nil
	
      respond_to do |format|
       # format.html { redirect_to gambles_url }
        #format.json { head :no_content }
	     format.js 
      end
	end
  end
end
