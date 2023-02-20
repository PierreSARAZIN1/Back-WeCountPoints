class PlayersController < ApplicationController
  before_action :set_player, only: %i[ show update destroy ]

  # GET /players
  def index
    @players = Player.all

    render json: @players
  end

  # GET /players/1
  def show
    render json: @player
  end

  # POST /players
  def create
    @player = Player.new(player_params)

    if Match.last.id < @player.match_id
     render json: @player.errors, status: :unprocessable_entity
    else
     if @player.save
      render json: @player, status: :created, location: @player
      @player.register_player_in_match(@player)
    else
      render json: @player.errors, status: :unprocessable_entity
    end
     
    end
  end

  # PATCH/PUT /players/1
  def update
    if @player.update(player_params)
      render json: @player
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  # DELETE /players/1
  def destroy
    @player.destroy
  end

  private

    def set_player
      @player = Player.find(params[:id])
    end

    def player_params
      params.require(:player).permit(:name, :level, :match_id)
    end
end
