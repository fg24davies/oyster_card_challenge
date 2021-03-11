require 'journeylog'

describe Journeylog do
   let(:journey) { double :journey }
   let(:station) { double :station }

   it { is_expected.to respond_to :journey }

  describe '#start' do

    it 'starts a new journey with an entry station' do
      expect(subject.start(station)).to eq station
     end
   end

   describe '#finish' do
     it 'add exit station to the current journey' do
       expect(subject.finish(station)).to eq station
     end
   end

   describe '#journeys' do

     it 'returns the journey history as a list' do
       subject.start(station)
       subject.finish(station)
       expect(subject.journeys).to eq [subject.journey]
     end
   end
end
