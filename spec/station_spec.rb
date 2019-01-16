require 'station'

describe Station do
  subject {described_class.new("Peckham Rye", 2)} 
  # let(:station_name) {double('station_name')}
  # let(:zone) {double('zone')}

  # it 'checks a station has a name and a zone' do
  #   station = Station.new(station_name, zone)
  #   expect(station.station_name).to eq (station_name)
  #   expect(station.zone).to eq (zone)

  it 'knows its name' do
    expect(subject.station_name).to eq("Peckham Rye")
  end

  it 'knows its zone' do
    expect(subject.zone).to eq(2)
  end

end
