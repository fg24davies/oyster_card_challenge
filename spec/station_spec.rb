require 'station'

describe Station do

    let(:station) { double :station }

    it 'has a name' do
        subject.name = station
        expect(subject.name).to eq(station)
    end

end