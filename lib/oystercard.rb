class Oystercard
  attr_accessor :balance
  attr_reader :journey_history
  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journey = Journey.new
    @journey_history = []
    @fare = MINIMUM_FARE
  end

  def  top_up(amount)
    raise 'Maximum balance reached' if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise 'Insufficient funds' if @balance < MINIMUM_FARE
    @journey.start_journey(station)
  end

  def touch_out(station)
    deduct(@fare)
    @journey.end_journey(station)
    save_journey
  end

  def save_journey
    @journey_history << @journey
  end

  def fare
    !@journey.journey_completed? ? @fare = 6 : @fare = MINIMUM_FARE
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
