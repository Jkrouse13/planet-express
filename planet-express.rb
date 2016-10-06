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
    if destination == " Earth"
      @pilot = "Fry"
    elsif destination == " Mars"
      @pilot = "Amy"
    elsif destination == " Uranus"
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
      pilot.include? flyer.downcase
    end
  end

  def fry?
    pilot == "Fry"
  end

  def amy?
    pilot == "Amy"
  end

  def bender?
    pilot == "Bender"
  end

  def leela?
    pilot == "Leela"
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





fry_flights = deliveries.select { |delivery| delivery.fry?}

fry_tips = fry_flights.reduce(0) { |sum, delivery| sum + delivery.money}/10.00

puts "Fry:"
puts fry_flights.length
puts fry_tips

amy_flights = deliveries.select { |delivery| delivery.amy?}

amy_tips = amy_flights.reduce(0) { |sum, delivery| sum + delivery.money}/10.00

puts "Amy:"
puts amy_flights.length
puts amy_tips

bender_flights = deliveries.select { |delivery| delivery.bender?}

bender_tips = bender_flights.reduce(0) { |sum, delivery| sum + delivery.money}/10.00


puts "Bender:"
puts bender_flights.length
puts bender_tips

leela_flights = deliveries.select { |delivery| delivery.leela?}

leela_tips = leela_flights.reduce(0) { |sum, delivery| sum + delivery.money}/10.00

puts "Leela:"
puts leela_flights.length
puts leela_tips
