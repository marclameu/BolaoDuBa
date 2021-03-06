class RoundsController < ApplicationController
  skip_before_filter :admin_user, :only => [:index, :show]
  # GET /rounds
  # GET /rounds.json
  def index
    championship = Championship.find_by_desc($current_championship)
    unless championship == nil?
      @rounds = Round.get_all_rounds_by_championship_id(championship.id, params[:page])
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json =>  @rounds }
    end
  end

  # GET /rounds/1
  # GET /rounds/1.json
  def show
    @round = Round.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json =>  @round }
    end
  end

  # GET /rounds/new
  # GET /rounds/new.json
  def new
    @championships = Championship.all
    @round = Round.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json =>  @round }
    end
  end

  # GET /rounds/1/edit
  def edit
    @round = Round.find(params[:id])
  end

  # POST /rounds
  # POST /rounds.json
  def create
    @round = Round.new(params[:round])
    params[:round][:start_date] = Date.strptime(params[:round][:start_date], '%d/%m/%Y').strftime.to_s
    params[:round][:end_date] = Date.strptime(params[:round][:end_date], '%d/%m/%Y').strftime.to_s

    if params[:championship][:championship_id] == ""
      respond_to do |format|
        flash[:error] = "Voce deve selecionar o campeonato"
        format.html { render :action =>  "new" }
      end
    else
      @championship = Championship.find(params[:championship][:championship_id])
      @last_round4_championship = Round.find_by_championship_id(@championship.id)
      @round.championship = @championship
      num_round = (@last_round4_championship == nil)? 1 : Round.maximum(:num_round) +1
      @round.num_round = num_round


      respond_to do |format|
        if @round.save
          format.html { redirect_to @round, :notice =>  'Round was successfully created.' }
          format.json { render :json =>  @round, :status =>  :created, :location =>  @round }
        else
          format.html { render :action =>  "new" }
          format.json { render :json =>  @round.errors, :status =>  :unprocessable_entity }
        end
      end
    end
  end

  # PUT /rounds/1
  # PUT /rounds/1.json
  def update
    @round = Round.find(params[:id])
    params[:round][:start_date] = Date.strptime(params[:round][:start_date], '%d/%m/%Y').strftime.to_s
    params[:round][:end_date] = Date.strptime(params[:round][:end_date], '%d/%m/%Y').strftime.to_s

    respond_to do |format|
      if @round.update_attributes(params[:round])
        format.html { redirect_to @round, :notice =>  'Round was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action =>  "edit" }
        format.json { render :json =>  @round.errors, :status =>  :unprocessable_entity }
      end
    end
  end

  # DELETE /rounds/1
  # DELETE /rounds/1.json
  def destroy
    @round = Round.find(params[:id])
    @round.destroy

    respond_to do |format|
      format.html { redirect_to rounds_url }
      format.json { head :no_content }
    end
  end
  
  def round4_finish
    @matches = Match.last_round_matches
    @round = @matches.first.round if (@matches.present?) and (@matches.first.round != nil)
  end
  
  def update_matches
    Match.update_all_matches(params[:round][:matches_attributes])
    redirect_to encerrar_partidas_path
    flash[:notice] = "Partidas atualizadas com sucesso!"
      #puts "ID = " + m[0].to_s
      #puts "Gols time 1 = " + m[1]["goals_team1"].to_s
      #puts "Gols time 2 = " + m[1]["goals_team2"].to_s      
    #end
    #match = Match.find()
    #Match.update_all(params[:round][:matches_attributes])
  end
  def num_round_select
  end
end
