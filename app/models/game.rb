require "elo.rb"

class Game < ActiveRecord::Base
  has_many :players
  has_many :users, through: :players
  accepts_nested_attributes_for :players

  validates :date_played, presence: true

  after_create :update_elo

  private

  def update_elo
    new_elo

    self.players.each_with_index do |player, i|
      player.user.update(elo: self.instance_variable_get("@player#{i+1}").rating)
    end
  end

  def new_elo
    Match.new(player1, player2, winner)
  end

  def player1
    @player1 ||= RatedPlayer.new("1", self.players[0].user.elo)
  end

  def player2
    @player2 ||= RatedPlayer.new("2", self.players[1].user.elo)
  end

  def winner
    self.players[0].score > self.players[1].score ? 1 : 0
  end
end
