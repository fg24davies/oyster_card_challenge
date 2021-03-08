class Oystercard
  attr_accessor :balance
  DEFAULT_BALANCE = 0
  CARD_LIMIT = 90
  
  def initialize
    @balance = DEFAULT_BALANCE
  end
  
  def top_up(amount)
    @balance += amount
    raise 'Maximum balance reached' if @balance > CARD_LIMIT
    @balance
  end
end