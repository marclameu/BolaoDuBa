class ChampionshipsController < ApplicationController
  skip_before_filter :admin_user, :only => [:index, :show, :set_championship_id_session]

  # GET /championships
  # GET /championships.json
  def index
    @championships = Championship.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @championships }
    end
  end

  # GET /championships/1
  # GET /championships/1.json
  def show
    @championship = Championship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @championship }
    end
  end

  # GET /championships/new
  # GET /championships/new.json
  def new
    @championship = Championship.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @championship }
    end
  end

  # GET /championships/1/edit
  def edit
    @championship = Championship.find(params[:id])
  end

  # POST /championships
  # POST /championships.json
  def create
    params[:championship][:start_date] = Date.strptime(params[:championship][:start_date], '%d/%m/%Y').strftime.to_s
    params[:championship][:end_date] = Date.strptime(params[:championship][:end_date], '%d/%m/%Y').strftime.to_s
    @championship = Championship.new(params[:championship])

    respond_to do |format|
      if  @championship.save
        format.html { redirect_to championships_url, :notice =>  'Campeonato ' + @championship.desc + ' foi criado com sucesso!'  }
        format.json { render :json => @championship, :status =>  :created, :location =>  @championship }
      else
        format.html { render :action =>  "new" }
        format.json { render :json => @championship.errors, :status =>  :unprocessable_entity }
      end
    end
  end

  # PUT /championships/1
  # PUT /championships/1.json
  def update
    @championship = Championship.find(params[:id])
    params[:championship][:start_date] = Date.strptime(params[:championship][:start_date], '%d/%m/%Y').strftime.to_s
    params[:championship][:end_date] = Date.strptime(params[:championship][:end_date], '%d/%m/%Y').strftime.to_s

    respond_to do |format|
      if @championship.update_attributes(params[:championship])
        format.html { redirect_to @championship, :notice =>  'Championship was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action =>  "edit" }
        format.json { render :json => @championship.errors, :status =>  :unprocessable_entity }
      end
    end
  end

  # DELETE /championships/1
  # DELETE /championships/1.json
  def destroy
    @championship = Championship.find(params[:id])
    @championship.destroy

    respond_to do |format|
      format.html { redirect_to championships_url }
      format.json { head :no_content }
    end
  end
  def set_championship_id_session  
    session[:championship_id] = params[:championship][:id]
  end
end
