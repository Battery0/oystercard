class Journey

  attr_accessor :start_station, :finish_station

  def initialize
    @start_station = nil
  end

  def start_journey(station)
    @start_station = station
  end

  def finish_journey(station)
    @finish_station = station
  end

  def in_journey? #Journey
    !@start_station.nil?
  end
end 
