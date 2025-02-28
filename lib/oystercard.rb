require_relative 'journey'

class Oystercard

  attr_reader :balance, :journeylog, :current_journey

  MAX_AMOUNT = 90
  MINIMUM_FARE = 1
  PENAULTY_FARE = 6

  def initialize
    @balance = 0
    @journeylog = Journeylog.new
    @current_journey = Journey.new
  end 

  def top_up(add)
    raise "Exceeds the limit #{MAX_AMOUNT}" if (@balance + add ) > MAX_AMOUNT

    @balance += add
  end

  def in_journey?
    !@current_journey.start_station.nil?
  end

  def touch_in(station)
    raise "Balance of #{@balance} does not meet minimum fare of #{MINIMUM_FARE}" if @balance < MINIMUM_FARE
    
    failed_to_touch_out if @current_journey.start_station != nil
    @current_journey = Journey.new
    @current_journey.start_journey(station)
  end

  def touch_out(station)
    @current_journey.finish_journey(station)
    journey_log(@current_journey.start_station, @current_journey.finish_station)
    deduct(fare(@current_journey))
    @current_journey = Journey.new
  end
  
  def fare(journey)
    if journey.start_station == nil || journey.finish_station == nil
      PENAULTY_FARE
    else
      MINIMUM_FARE
    end
  end

  private

  def failed_to_touch_out
    journey_log(@current_journey.start_station, nil)
    deduct(fare(@current_journey))
  end
  
  def deduct(subtract)
    @balance -= subtract
  end

  def journey_log(entry, exit)
      @journeylog.journeys << { Start: entry, End: exit } 
  end
end