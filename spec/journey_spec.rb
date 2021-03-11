require 'journey'

describe Journey do
  let(:journey) { Journey.new }
  let(:station) { double :station }
  let(:other_station) { double :other_station }

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

  describe '#calculate_fare' do
    before do
      journey.start_journey(station)
      journey.end_journey(other_station)
    end

      it 'should charge 1 for a single zone trip' do
        update_zones(1, 1)
        expect(journey.calculate_fare).to eq 1
      end

      it 'should charge 2 for a 2 zone trip' do
        update_zones(1, 2)
        expect(journey.calculate_fare).to eq 2
      end
      it 'should do zone 2 and 3 ?!' do
        update_zones(2,3)
        expect(journey.calculate_fare).to eq 2
      end
      it 'should charge 3 for a 3 zone trip' do
        update_zones(3, 5)
        expect(journey.calculate_fare).to eq 3
      end

      it 'should still charge 1 for 1 zone trip' do
        update_zones(3, 3)
        expect(journey.calculate_fare).to eq 1
      end
      def update_zones(entry_zone,exit_zone)
        allow(station).to receive(:zone).and_return(entry_zone)
        allow(other_station).to receive(:zone).and_return(exit_zone)
    end
  end
end
