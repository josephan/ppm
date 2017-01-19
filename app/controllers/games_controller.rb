class GamesController < ApplicationController
  def index
    @games = current_user.games
  end

  def new
    @game = current_user.games.new
  end

  def create
    @game = current_user.games.create(game_params)
    if @game.save
      render action: "index"
    else
      flash[:danger] = "There was an error with your game"
      render 'new'
    end
  end

  private

  def game_params
    params.require(:game).permit(:opponent, :user_score, :opponent_score, :date_played)
  end
end
