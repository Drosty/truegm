class NflPlayersController < ApplicationController

  # GET /nfl_players
  # GET /nfl_players.json
  def index
    @players = NflPlayer.all.order(:salary)
  end

end
