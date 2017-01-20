class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  validates :user, presence: true
  validates :score, numericality: true, inclusion: 0..21
end
