class MatchesController < ApplicationController
  before_action :set_match, only: %i[ show update destroy ]
  before_action :match_params, only: %i[ create update ]

  # GET /matches
  def index
    @matches = Match.all

    render json: @matches
  end

  # GET /matches/1
  def show
     @match.is_finished ? 
     json = @match.as_json.merge({
        sets: @match.tennis_sets.order(:id).as_json,
        players: @match.players.as_json
        })
     : 
     json = @match.as_json.merge({
        sets: @match.tennis_sets.order(:id).as_json,
        current_game: @match.tennis_sets.last.games.last.as_json,
        players: @match.players.as_json
        })
     render json: json
  end

  # POST /matches
  def create
    @match = Match.new(match_params)

    if @match.save
      render json: @match, status: :created, location: @match
    else
      render json: @match.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /matches/1
  def update
    if @match.update(match_params)
      render json: @match
    else
      render json: @match.errors, status: :unprocessable_entity
    end
  end

  # DELETE /matches/1
  def destroy
    @match.destroy
  end

  private

    def set_match
      @match = Match.find(params[:id])
    end
 
    def match_params
      params.require(:match).permit(:isFinished, :player_one, :player_two)
    end
end
