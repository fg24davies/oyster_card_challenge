require 'oystercard'

describe Oystercard do
  let(:journey) { double :journey }

  describe 'when first created' do

    it { is_expected.to respond_to(:balance) }

    it 'initialises with a balance of zero' do
      expect(subject.balance).to eq 0
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
      expect(subject.touch_in(station)).to be station
    end

    it 'prevents touch in when balance is below £1' do
      expect { subject.touch_in(station) }.to raise_error('Insufficient funds')
    end
  end

  describe 'touch_out' do

    let(:station) { double :station }

    it { is_expected.to respond_to(:touch_out)}

  end

  describe '#fare' do
    it 'should calculate a fine if journey not completed' do
      allow(journey).to receive(:journey_completed?) { true }
      expect(subject.fare).to eq 6
    end
  end

end
