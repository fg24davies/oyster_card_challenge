class Journey
  BASE_FARE = 1

  attr_reader :current_journey

  def initialize
    @current_journey = { entry_station: nil, exit_station: nil}
    @zone_array = []
  end

  def start_journey(station)
    @current_journey[:entry_station] = station
  end

  def end_journey(station)
    @current_journey[:exit_station] = station
  end

  def journey_completed?
    !@current_journey.has_value?(nil)
  end

  def zone_array
    @zone_array = @current_journey.map { |key, value|
      value.zone }
  end

  def calculate_fare
    zone_array
    @zone_array.uniq.length == 1 ? BASE_FARE : (zone_array.max - zone_array.min) + BASE_FARE
  end

end
