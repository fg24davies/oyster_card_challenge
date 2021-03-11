class Journey

  attr_reader :current_journey

  def initialize
    @current_journey = { entry_station: nil, exit_station: nil}
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

end
