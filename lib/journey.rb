class Journey

  attr_accessor :start_station 

  def initialize
    @start_station = nil
  end

  def start_journey(station)
    @start_station = station
  end
end 
