require 'journey'

describe Journey do
  let(:journey) { Journey.new }
  let(:station) { double :station }
  describe '#start_journey' do
    it 'should save the start of the journey' do
      expect(journey.start_journey(station)).to eq station
    end
  end
  describe '#end_journey' do
    it 'should save the end of the journey' do
      expect(journey.end_journey(station)).to eq station
    end
    it 'should save both' do
      journey.start_journey(station)
      journey.end_journey(station)
      expect(journey.current_journey).not_to eq nil
    end
  end

  describe '#journey_completed?' do
    it 'should know if the journey is finished' do
      journey.start_journey(station)
      journey.end_journey(station)
      expect(journey.journey_completed?).to eq true
    end
    it 'should know if the journey is not finished' do
      journey.start_journey(station)
      expect(journey.journey_completed?).to eq false
    end
  end
end
