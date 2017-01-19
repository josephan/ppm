module GamesHelper
  def game_date(game)
    game.date_played.strftime("%b %-d")
  end

  def game_opponent(game)
    game.users.pluck(:name).find { |n| n != current_user.name }
  end

  def game_score(game)
    "#{current_user_score(game)}-#{opponent_score(game)}"
  end

  def game_result(game)
    current_user_score(game) > opponent_score(game) ? "W" : "L"
  end

  def current_user_score(game)
    game.players.find_by(user: current_user).score
  end

  def opponent_score(game)
    game.players.reject { |p| p.user == current_user }.first.score
  end
end
