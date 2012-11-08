class RegistrationsController < Devise::RegistrationsController
  def new
    @teams = Team.all
    @championships = Championship.all
    resource = build_resource({})
    respond_with resource
  end

  def create
    resource = build_resource({})
    #build_resource
    resource.errors.add("", "Escolha seu time") if params[:team][:id] == ""
    resource.errors.add("", "Voce deve selecionar um campeonato") if params[:championship][:id] == ""
    if resource.errors.empty? #and current_user.present?
       super   
       current_user.teams << Team.find(params[:team][:id]) if current_user.present?
       current_user.participations << Participation.new(:championship_id => params[:championship][:id].to_i) if current_user.present?
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
