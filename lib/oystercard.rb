class Oystercard
  attr_accessor :balance
  attr_reader :journey_history
  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  FINE = 6

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journey = Journeylog.new
    @journey_fare = Journey.new
  end

  def top_up(amount)
    raise 'Maximum balance reached' if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise 'Insufficient funds' if @balance < MINIMUM_FARE
    @journey.start(station)
  end

  def touch_out(station)
    @journey.finish(station)
    deduct(fare)
    save_journey
  end

  def save_journey
    @journey.journeys
  end

  def fare
    @journey_fare.journey_completed? ? @journey_fare.calculate_fare : FINE
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
