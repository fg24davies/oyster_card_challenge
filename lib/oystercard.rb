class Oystercard
  attr_accessor :balance, :in_use
  DEFAULT_BALANCE = 0
  MINIMUM_BALANCE = 1
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  
  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_use = false 
  end
  
  def  top_up(amount)
    @balance += amount
    raise 'Maximum balance reached' if @balance > MAXIMUM_BALANCE
    @balance
  end

  def touch_in
    if @balance < MINIMUM_BALANCE
      raise 'Insufficient funds'
    end
    @in_use = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_use = false
  end

  def in_journey?
    @in_use
  end

  private
  
  def deduct(amount)
    @balance -= amount
  end

end