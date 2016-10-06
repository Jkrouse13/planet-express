require_relative 'data_parser'

require 'csv'

class Delivery

  attr_accessor :destination,
                :shipment,
                :crates,
                :money,
                :pilot

  def initialize(destination:, shipment:, crates:, money:)
    @destination = destination
    @shipment = shipment
    @crates = crates
    @money = money.to_i
    determine_pilot
  end

  def determine_pilot
    if @destination == " Earth"
      @pilot = "Fry"
    elsif @destination == " Mars"
      @pilot = "Amy"
    elsif @destination == " Uranus"
      @pilot = "Bender"
    else
      @pilot =  "Leela"
    end
  end

  def say_pilot
    "Pilot for this trip was #{pilot}"
  end

  def profit
    self.reduce(0) { |sum, money| sum + money[:money]}
  end

  def piloted?(flyer)
    pilot.collect { |name| name.downcase }.detect do |pilot|
      pilot.include? pilot.downcase
    end
  end


end


deliveries_array = CSV.foreach("planet_express_logs.csv", headers: true, header_converters: :symbol)

deliveries = deliveries_array.collect { |deliveries| Delivery.new(deliveries)}


puts deliveries.inspect

total_profit = deliveries.reduce(0) { |sum, delivery| sum + delivery.money}

puts total_profit


deliveries.each do |name|
 puts name.pilot
end
