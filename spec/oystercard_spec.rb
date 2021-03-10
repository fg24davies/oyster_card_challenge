require 'oystercard'

describe Oystercard do

  describe 'when first created' do

    it { is_expected.to respond_to(:balance) }

    it 'initialises with a balance of zero' do
      expect(subject.balance).to eq 0
    end
    
    it 'starts with an empty journey history' do 
      expect(subject.journeys).to eq([])
    end


  end

  describe 'top up features' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'increases the balance by the argument amount using :top_up' do
      expect { subject.top_up(10) }.to change { subject.balance }.by(10)
    end

    it 'raises an error if the top_up method puts balance over £90' do
      expect { subject.top_up(100) }.to raise_error('Maximum balance reached')
    end
  end

  describe 'touch_in' do

    let(:station) { double :station }

    it { is_expected.to respond_to(:touch_in) }

    it 'store a true value if card was touched in' do
      subject.top_up(5)
      expect(subject.touch_in(station)).to be(true)
    end

    it 'prevents touch in when balance is below £1' do
      expect { subject.touch_in(station) }.to raise_error('Insufficient funds')
    end

    it 'records the entry station of the current journey' do   
      subject.top_up(1)
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station) 
    end
  end

  describe 'touch_out' do

    let(:station) { double :station }

    it { is_expected.to respond_to(:touch_out)}

    it 'deducts card balance by the fare'  do
      subject.top_up(1)
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to change { subject.balance }.by (-Oystercard::MINIMUM_FARE)
    end

    it 'sets entry_station to nil' do
      subject.top_up(1)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.entry_station).to eq(nil)
    end

    it 'records the exit station of the journey' do
      subject.top_up(1)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.exit_station).to eq(station)
    end

    it 'adds the exit station to the journey history' do
      subject.top_up(1)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.journeys.last).to include({ exit_station: station })
    end
    
    it 'will create one complete journey' do
      subject.top_up(1)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.journeys.length).to eq(1)
    end
  end
  
  describe 'in_journey?' do

    let(:station) { double :station }

    it { is_expected.to respond_to(:in_journey?)}

    it 'returns true when on a journey' do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'returns false when not on a journey' do
      subject.top_up(5)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject).to_not be_in_journey
    end
  end
end
