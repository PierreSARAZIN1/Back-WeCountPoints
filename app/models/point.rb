class Point < ApplicationRecord

 belongs_to :player
 belongs_to :match

 

 def use_point

  @point_id = self.id
  @player_id = self.player_id
  @game = match.tennis_sets.last.games.last
  @player_one_finded = Player.find_by(id: match.player_one)
  @player_two_finded = Player.find_by(id: match.player_two)
  


 # STEP 1 - Check if it is necessary to create a new set ?
  def is_last_set_over
   case match.tennis_sets.last.is_finished
   when false
    is_last_game_over
    
   when true 
    match.tennis_sets.new(player_one: @player_one_finded.id, player_two: @player_two_finded.id).save
    match.tennis_sets.last.games.new(player_one: @player_one_finded.id, player_two: @player_two_finded.id).save
    @game = match.tennis_sets.last.games.last
    who_scored_the_point
   end
  end

 # STEP 2 - Check if it is necessary to create a new game ?
  def is_last_game_over
   case match.tennis_sets.last.games.last.is_finished
    when false
     who_scored_the_point
     
    when true
      match.tennis_sets.new(player_one: @player_one_finded.id, player_two: @player_two_finded.id).save
      match.tennis_sets.last.games.new(player_one: @player_one_finded.id, player_two: @player_two_finded.id).save
      @game = match.tennis_sets.last.games.last
      who_scored_the_point
    end
  end

  # STEP 3 - Give the point to the right player ?
  def who_scored_the_point
   if @player_id == @game.player_one
    @game.player_one_score += 1
    @game.save
    self.is_analyzed = true
    self.save
    does_this_point_close_the_game
   else
    @game.player_two_score += 1
    @game.save
    self.is_analyzed = true
    self.save
    does_this_point_close_the_game
   end
  end
  
  # STEP 4 - check if this point ends the game ?
  def does_this_point_close_the_game
   case @game.is_decisive
   when false
    how_to_win_a_game(4)
   when true
    how_to_win_a_game(7)
   end
  end

  def how_to_win_a_game(min_point_to_win)
   if  @game.player_one_score >= min_point_to_win && (@game.player_one_score - @game.player_two_score >= 2)
    player_won_the_game(@game.player_one)
   elsif @game.player_two_score >= min_point_to_win && (@game.player_two_score - @game.player_one_score >= 2)
    player_won_the_game(@game.player_two)
   else
    puts "Le jeu n'est pas terminé"
   end
  end
  
  # STEP 5 - Update game
  def player_won_the_game(player_id)
   @game.winner_id = player_id
   @game.is_finished = true
   @game.save
   case @game.is_decisive
   when false
    game_is_over_does_it_end_the_set(player_id, 6, 2)
   when true
    game_is_over_does_it_end_the_set(player_id, 7, 1)
   end
   
  end

  def lets_play_a_decisive_game
   match.tennis_sets.last.games.new(player_one: @player_one_finded.id, player_two: @player_two_finded.id, is_decisive: true).save
  end

  # STEP 6 - Check if the game ends the set
  def game_is_over_does_it_end_the_set(player_id, min_point_to_win, gap)
   if player_id == @game.tennis_set.player_one
    @game.tennis_set.player_one_score += 1
    @game.tennis_set.save
    if @game.tennis_set.player_one_score >= min_point_to_win && (@game.tennis_set.player_one_score - @game.tennis_set.player_two_score >= gap)
     @player_one_finded.number_of_sets_won += 1
     @player_one_finded.save
     this_point_close_the_set(player_id)
    elsif @game.is_decisive == false && @game.tennis_set.player_one_score == 6 && @game.tennis_set.player_two_score == 6
     lets_play_a_decisive_game
    else
     match.tennis_sets.last.games.new(player_one: @player_one_finded.id, player_two: @player_two_finded.id).save
    end
   else
    @game.tennis_set.player_two_score += 1
    @game.tennis_set.save
    if @game.tennis_set.player_two_score >= min_point_to_win &&(@game.tennis_set.player_two_score - @game.tennis_set.player_one_score >= gap)
    @player_two_finded.number_of_sets_won += 1
    @player_two_finded.save
    this_point_close_the_set(player_id)
    elsif @game.is_decisive == false && @game.tennis_set.player_two_score == 6 && @game.tennis_set.player_one_score == 6
    lets_play_a_decisive_game
    else
     match.tennis_sets.last.games.new(player_one: @player_one_finded.id, player_two: @player_two_finded.id).save
    end
   end
  end

  def this_point_close_the_set(player_id)
   @game.tennis_set.is_finished = true
   @game.tennis_set.winner_id = player_id
   @game.tennis_set.save
   does_this_point_end_the_match(player_id)
  end
  
  # STEP 7 - Check if the set ends the match
  def does_this_point_end_the_match(player_id)
   if @player_one_finded.number_of_sets_won == 3
    match.is_finished = true
    match.winner_id = match.player_one
    match.save
   elsif @player_two_finded.number_of_sets_won == 3
    match.is_finished = true
    match.winner_id = match.player_two
    match.save
   else
    puts "Le match n'est pas terminé"
   end
  end
  
  is_last_set_over

 end
 
end
