require 'oystercard'
# challenge 3: I want to my card to have a balance
describe Oystercard do
  card = Oystercard.new

  it 'creates a new card with a balance of 0' do
    expect(card.balance).to eq(0)
  end
# challenge 5: I want to top up my card
  it 'tops up the balance of the card' do
    allow(card).to receive(:balance) { 0 }
    expect(card.top_up(5)).to eq(5)
  end

end 
