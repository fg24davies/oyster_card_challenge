require 'oystercard'

describe Oystercard do
  card = Oystercard.new

  it 'creates a new card with a balance of 0' do
    expect(card.balance).to eq(0)
  end
end 
