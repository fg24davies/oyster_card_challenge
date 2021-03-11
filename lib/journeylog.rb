class Journeylog
  attr_reader :journey, :journeys
  
  def initialize
    @journey = Journey.new
    @journeys = []
  end 

  def start(station)
    @journey.start_journey(station)
  end

  def finish(station)
    @journey.end_journey(station)
  end

  def journeys
    @journeys << @journey
  end 

  private 

  def current_journey
    @journey.current_journey
  end
  

end