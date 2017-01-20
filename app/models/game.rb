class Game < ActiveRecord::Base
  has_many :players
  has_many :users, through: :players
  accepts_nested_attributes_for :players

  validates :date_played, presence: true
end
