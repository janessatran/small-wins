class WinsController < ApplicationController 
  def index
    @small_wins = GoogleSheetsReader.new.get_wins_as_csv
    @csv_table = CSV.parse(@small_wins, headers: true)
  end

  def show
  end
end
