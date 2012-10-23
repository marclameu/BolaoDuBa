#comentarios Flavio MERGE de arquivos
#comentarios Flavio
class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, :only =>['show']
  def admin
  end
  # GET /users
  # GET /users.json
  def index
    #@user = User.all(:joins => :teams)
    @user = User.find(current_user.id)
    if @user.teams.present?
      team_user_id = @user.teams.first.id
      @match =  Match.user_matches(team_user_id)
      @match = (@match == nil)? nil : @match.first
    #else
      #@match = Match.first
    end
    unless @match == nil
      @gambles = Gamble.find_all_user_gambles(@user)
      @team = @user.teams.first
  	  @gamble4_current_match = current_user.gambles.joins(:match).where("matches.id = ?",[@match.id])
  	  @gamble = (@gamble4_current_match.present?)? @gamble4_current_match.first : Gamble.new
  	  #@gamble = Gamble.new
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    #@user = User.find(params[:id])
    if user_signed_in?
      @user = current_user
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    else
      redirect_to new_user_session_path
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    #@team = Team.find(params[:team_id])
	  #@user.teams << @team
	
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
  def new_gamble
  end
end
#Comentário de Marcelino lameu da silva
#Mais um comentário de Marcelino lameu da silva
