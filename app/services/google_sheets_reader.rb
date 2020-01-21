require 'csv'
require 'json'
require 'googleauth'


class GoogleSheetsReader
  
  attr_reader :spreadsheet, :worksheet, :session, :title

  def initialize
    @title = "Win List"
    key = JSON.parse(JSON.dump(ENV["google_sheets_client_secret"]))
    @session = GoogleDrive::Session.from_service_account_key(StringIO.new(key))
    # @session = GoogleDrive::Session.from_service_account_key("./config/client_secret.json")
  end

  def get_wins
    self.read_spreadsheet(title)
  end

  def get_wins_as_csv    
    convert_array_to_csv(self.read_spreadsheet(title))
  end
  
  protected

  def read_spreadsheet(title)
    @spreadsheet = session.spreadsheet_by_title(title)
    @worksheet = spreadsheet.worksheets.first.rows
  end

  def convert_array_to_csv(rows)
    csv_str = rows.inject([]) { |csv, row|  csv << CSV.generate_line(row) }.join("")
  end
end