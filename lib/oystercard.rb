class Oystercard
  attr_accessor :balance
  attr_reader :entry_station, :exit_station, :journeys
  DEFAULT_BALANCE = 0
  MINIMUM_BALANCE = 1
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  
  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance 
    @entry_station = nil
    @exit_station
    @journeys = []
  end
  
  def  top_up(amount)
    @balance += amount
    raise 'Maximum balance reached' if @balance > MAXIMUM_BALANCE
    @balance
  end

  def touch_in(station)
    if @balance < MINIMUM_BALANCE
      raise 'Insufficient funds'
    end
    @entry_station = station
    @journeys.push({ entry_station: station })
    in_journey?   
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @journeys.last.merge!({ exit_station: station })
    @exit_station = station
    in_journey?
  end

  def in_journey?
    false if @entry_station == nil
    true if @entry_station != nil
  end

  private
  
  def deduct(amount)
    @balance -= amount
  end



end