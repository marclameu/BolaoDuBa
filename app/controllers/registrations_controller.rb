class RegistrationsController < Devise::RegistrationsController
  def new
    @teams = Team.all
    resource = build_resource({})
    respond_with resource
  end

  def create
    #resource = build_resource({})
    build_resource
    if params[:team][:id] == ""
      resource.errors.add("", "Escolha seu time")
      respond_with resource 
    else
      super   
      current_user.teams << Team.find(params[:team][:id]) if current_user.present?
    end
    
    #if (params[:team][:id] == nil) or (params[:team][:id] == "")
    #  flash[:erro] = "Selecione seu time" 
    #  redirect_to sign_up_path
    #else
    #  super
    #  current_user.teams << Team.find(params[:teams][:id]) if current_user.present?
    #end
    #resource.errors.add(:teams, "Selecione seu time!") if params[:teams][:id] == nil
	  #current_user.teams << Team.find(params[:teams][:id]) if current_user.present?
  end

  def update
    super
  end
end
