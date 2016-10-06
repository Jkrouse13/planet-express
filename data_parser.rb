require 'csv'
require_relative 'planet-express'


CSV.foreach("planet_express_logs.csv", headers: true, :header_converters => :symbol) do |row|
  puts row.inspect
  # replace with your logic
end
