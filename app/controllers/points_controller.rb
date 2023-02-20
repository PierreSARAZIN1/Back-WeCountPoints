class PointsController < ApplicationController
  before_action :set_match, :set_player, only: %i[ create ]
  before_action :set_point, only: %i[ show update destroy ]

  # GET /points
  def index
    @points = Point.all

    render json: @points
  end

  # GET /points/1
  def show
    render json: @point
    
  end

  # POST /points
  def create

    if @match.is_finished == false
     @point = @match.points.new(player: @player)
     if @point.save
      @point.use_point
      render json: @point, status: :created, location: @point
     else
      render json: @point.errors, status: :unprocessable_entity
     end
    else
     json = @match.as_json.merge({
     sets: @match.tennis_sets.as_json
     })
     render json: json
    end


  end

  # PATCH/PUT /points/1
  def update
    if @point.update(point_params)
      render json: @point
    else
      render json: @point.errors, status: :unprocessable_entity
    end
  end

  # DELETE /points/1
  def destroy
    @point.destroy
  end

  private

    def set_match
      @match = Match.find(params[:match_id])
    end

    def set_player
      @player = Player.find(params[:player_id])
    end

    def set_point
      @point = Point.find(params[:id])
    end

    def point_params
      params.require(:point).permit(:player_id, :match_id)
    end

end
