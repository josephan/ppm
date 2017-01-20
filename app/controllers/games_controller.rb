class GamesController < ApplicationController
  def index
    @games = current_user.games
  end

  def new
    @game = Game.new
    @opponents = User.where.not(id: current_user.id).pluck(:name, :id)
  end

  def create
    @game = Game.new(date_played: game_params[:date_played])
    player = @game.players.build(user: current_user, score: game_params[:player][:score])
    opponent = @game.players.build(user_id: game_params[:opponent][:user], score: game_params[:opponent][:score])
    if @game.save && player.save && opponent.save
      flash[:success] = "Your game has been succesfully saved!"
      redirect_to games_url
    else
      flash[:danger] = "There was an error with your game"
      render 'new'
    end
  end

  private

  def game_params
    params.require(:game).permit(:date_played, opponent: [:user, :score], player: [:score])
  end
end
