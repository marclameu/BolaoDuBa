class GamblesController < ApplicationController
  # GET /gambles
  # GET /gambles.json
  def index
    @gambles = Gamble.all
    @teste[1] = "active"
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @gambles }
    end
  end

  # GET /gambles/1
  # GET /gambles/1.json
  def show
    @gamble = Gamble.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gamble }
    end
  end

  # GET /gambles/new
  # GET /gambles/new.json
  def new
    @gamble = Gamble.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gamble }
    end
  end

  # GET /gambles/1/edit
  def edit
    @gamble = Gamble.find(params[:id])
  end

  # POST /gambles
  # POST /gambles.json
  def create
    @gamble = Gamble.new(params[:gamble])

    respond_to do |format|
      if @gamble.save
        format.html { redirect_to @gamble, notice: 'Gamble was successfully created.' }
        format.json { render json: @gamble, status: :created, location: @gamble }
      else
        format.html { render action: "new" }
        format.json { render json: @gamble.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /gambles/1
  # PUT /gambles/1.json
  def update
    @gamble = Gamble.find(params[:id])

    respond_to do |format|
      if @gamble.update_attributes(params[:gamble])
        format.html { redirect_to @gamble, notice: 'Gamble was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @gamble.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gambles/1
  # DELETE /gambles/1.json
  def destroy
    @gamble = Gamble.find(params[:id])
    @gamble.destroy

    respond_to do |format|
      format.html { redirect_to gambles_url }
      format.json { head :no_content }
    end
  end
end
