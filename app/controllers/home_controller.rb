class HomeController < ApplicationController
  def index
    @ranked_users = User.all.order(elo: :desc)
  end
end
