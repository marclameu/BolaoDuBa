class MatchesController < ApplicationController
  skip_before_filter :admin_user

  def update_round_select
    @current_round = Round.current_round(params[:championship][:id].to_s)
    respond_to do |format|
      format.js
    end
  end
  # GET /matches
  # GET /matches.json
  def index
    #@matches = Match.all
    #@matches = Match.matches_after_date(ApplicationHelper.get_utc_time, params[:page])
    @matches = Match.last_round_matches(params[:page])
    @num_round = (@matches.present?)? @matches.first.round.num_round : nil
    @teams = Team.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json =>  @matches }
    end
  end

  # GET /matches/1
  # GET /matches/1.json
  def show
    @match = Match.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json =>  @match }
    end
  end

  # GET /matches/new
  # GET /matches/new.json
  def new
    @match = Match.new
    @teams = Team.all
    @championships = Championship.all
    @current_round = (@championships == nil)? nil: Round.current_round(@championships.first.id)    
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json =>  @match }
    end
  end

  # GET /matches/1/edit
  def edit
    @match = Match.find(params[:id])
  end

  # POST /matches
  # POST /matches.json
  def create
    #puts "o round " + params[:round_id]
    @match = Match.new(params[:match])
    @team = Team.find(params[:team1][:id])
    @match.team1 = @team    
    @team = Team.find(params[:team2][:id])
    @match.team2 = @team
    @match.round = Round.find(params[:round_id])

    respond_to do |format|
      if @match.save
        format.html { redirect_to @match, :notice =>  'Match was successfully created.' }
        format.json { render :json =>  @match, :status =>  :created, :location =>  @match }
      else
        format.html { render :action =>  "new" }
        format.json { render :json =>  @match.errors, :status =>  :unprocessable_entity }
      end
    end
  end

  # PUT /matches/1
  # PUT /matches/1.json
  def update
    @match = Match.find(params[:id])

    respond_to do |format|
      if @match.update_attributes(params[:match])
        format.html { redirect_to @match, :notice =>  'Match was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action =>  "edit" }
        format.json { render :json =>  @match.errors, :status =>  :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    @match = Match.find(params[:id])
    @match.destroy

    respond_to do |format|
      format.html { redirect_to matches_url }
      format.json { head :no_content }
    end
  end

end
