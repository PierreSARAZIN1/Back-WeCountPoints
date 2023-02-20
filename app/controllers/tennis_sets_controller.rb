class TennisSetsController < ApplicationController
  before_action :set_match, :tennis_set_params, only: %i[ create ]
  before_action :set_tennis_set, only: %i[ show update destroy ]

  # GET /tennis_sets
  def index
    @tennis_sets = TennisSet.all

    render json: @tennis_sets
  end

  # GET /tennis_sets/1
  def show
    render json: @tennis_set
  end

  # POST /tennis_sets
  def create
    @tennis_set = @match.tennis_sets.new(tennis_set_params)
    if @tennis_set.save
      render json: @tennis_set, status: :created, location: @tennis_set
    else
      render json: @tennis_set.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tennis_sets/1
  def update
    if @tennis_set.update(tennis_set_params)
      render json: @tennis_set
    else
      render json: @tennis_set.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tennis_sets/1
  def destroy
    @tennis_set.destroy
  end

  private

    def set_match
     @match = Match.find(params[:match_id])
    end

    def set_tennis_set
      @tennis_set = TennisSet.find(params[:id])
    end
    
    def tennis_set_params
      params.require(:tennis_set).permit(:is_finished)
    end
end
