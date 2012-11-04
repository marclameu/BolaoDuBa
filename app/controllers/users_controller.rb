class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, :only =>['show']
  def admin
  end
  # GET /users
  # GET /users.json
  #Por enquanto, só será considerado o primeiro time escolhido pelo usuário
  def index
    if current_user.teams.present?
      team_user_id = current_user.teams.first.id
      @match = Match.user_matches4_last_round(team_user_id)
    end
    unless @match == nil
      @match = @match.first
      @gamble = Gamble.find_user_gamble4_last_round(current_user.id)
      @gamble = (@gamble.present?)? @gamble.first : Gamble.new
    end
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    #@user = User.find(params[:id])
    if user_signed_in?
      #@user = current_user
      @user = User.find(params[:id])
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
    #@user = User.find(params[:id])
    @user = current_user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    #o usuário está sendo criado no devise registration.
	
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
    #@user = User.find(params[:id])
    @user = current_user

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
    #@user = User.find(params[:id])
    @user = current_user
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
  def new_gamble
  end
  
  def ranking
    @ranked_users = User.ranking
    @num_round = @ranked_users.first.gambles.first.match.round.num_round
    @championship_name = @ranked_users.first.gambles.first.match.round.championship.desc
    respond_to do |format|
      format.html
      format.json
    end
  end
end
#Comentário de Marcelino lameu da silva
#Mais um comentário de Marcelino lameu da silva
