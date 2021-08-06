require_relative 'journey'

class Oystercard

  attr_reader :balance, :entry_station, :journeys, :current_journey #entry_station Journey

  MAX_AMOUNT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journeys = [] # full of Journey objects
    @current_journey = Journey.new
  end 

  def top_up(add)
    raise "Exceeds the limit #{MAX_AMOUNT}" if (@balance + add ) > MAX_AMOUNT
    
    @balance += add
  end

  def in_journey? #Journey
    !@station.nil?
  end

  def touch_in(station)
    raise "Balance of #{@balance} does not meet minimum fare of #{MINIMUM_FARE}" if @balance < MINIMUM_FARE
    journey_log(@station, nil) if @station != nil # Journey
    @current_journey.start_journey(station) # Journey
  end

  def touch_out(station)
    self.journey_log(@station, station) # Journey
    @station = nil # Journey
    self.deduct(MINIMUM_FARE)
  end
  
  private
  
  def deduct(subtract)
    @balance -= subtract
  end

  def journey_log(entry, exit)
      @journeys << { Start: entry, End: exit } 
  end
end