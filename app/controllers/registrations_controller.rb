class RegistrationsController < Devise::RegistrationsController
  def new
    @teams = Team.all
    super
  end

  def create
    super
    #@user = User.new(params[:user])
    #team = Team.find(params[:team][:id])
    #puts "Classe = #{team.class}"
	  #@user.teams << (team == nil)? nil : team
	  #@user.teams << Team.find(params[:team][:id])
	  current_user.teams << Team.find(params[:team][:id])
    /respond_to do |format|
      if current_user.save
        #format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        #redirect_to root_path
      else
        format.html { render action: "new" }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
    /
  end

  def update
    super
  end
end
