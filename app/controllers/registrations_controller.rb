class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :admin_user

  def new
    @teams = Team.all
    resource = build_resource({})
    respond_with resource
  end

  def create
    #resource = build_resource({})
    resource = build_resource({}) if resource == nil
    resource.errors.add("-", "Escolha seu time") if params[:team][:id] == ""
    resource.errors.add("-", "Voce deve selecionar um campeonato") if params[:championship][:id] == ""
    resource.errors.add("-", "Insira seu email") if params[:user][:email] == ""
    resource.errors.add("-", "Insira seu CPF") if params[:user][:cpf] == ""
    resource.errors.add("-", "Insira sua data de nascimento") if params[:user][:born_date] == ""
    resource.errors.add("-", "Insira sua senha") if params[:user][:password] == ""

    if resource.errors.empty? #and current_user.present?
       params[:user][:born_date] = Date.strptime(params[:user][:born_date], '%d/%m/%Y').strftime.to_s unless params[:user][:born_date] == nil       
       super   
       current_user.teams << Team.find(params[:team][:id]) if current_user.present?
       current_user.participations << Participation.new(:championship_id => params[:championship][:id].to_i, :user_points => 0) if current_user.present?
    else
       respond_with resource
    end
  end

  def edit
    render :edit
  end
  
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    if resource.update_with_password(resource_params)
      if is_navigational_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
end
