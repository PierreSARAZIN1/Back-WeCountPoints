require "test_helper"

class TennisSetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tennis_set = tennis_sets(:one)
  end

  test "should get index" do
    get tennis_sets_url, as: :json
    assert_response :success
  end

  test "should create tennis_set" do
    assert_difference("TennisSet.count") do
      post tennis_sets_url, params: { tennis_set: { is_finished: @tennis_set.is_finished, looser_score: @tennis_set.looser_score, winner_score: @tennis_set.winner_score } }, as: :json
    end

    assert_response :created
  end

  test "should show tennis_set" do
    get tennis_set_url(@tennis_set), as: :json
    assert_response :success
  end

  test "should update tennis_set" do
    patch tennis_set_url(@tennis_set), params: { tennis_set: { is_finished: @tennis_set.is_finished, looser_score: @tennis_set.looser_score, winner_score: @tennis_set.winner_score } }, as: :json
    assert_response :success
  end

  test "should destroy tennis_set" do
    assert_difference("TennisSet.count", -1) do
      delete tennis_set_url(@tennis_set), as: :json
    end

    assert_response :no_content
  end
end
