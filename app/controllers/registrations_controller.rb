class RegistrationsController < Devise::RegistrationsController
  def new
    @teams = Team.all
    super
  end

  def create
    @user = User.new(params[:user])
    #@team = Team.find(params[:team][:id].to_i)
	  #@user.teams << (@team == nil)? nil : @team
	  @user.teams << Team.find(params[:team][:id].to_i)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        root_path
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    super
  end
end
