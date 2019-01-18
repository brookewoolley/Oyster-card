require 'journey'

describe Journey do
  # let(:card) {double('card')}
  let(:station) {double('station')}

  subject {described_class.new("Peckham Rye", "Shoreditch")}

  it 'knows the entry entry_station' do
    expect(subject.entry_station).to eq("Peckham Rye")
  end

  it 'knows the exit station' do
    expect(subject.exit_station).to eq("Shoreditch")
  end

  it 'can accept an exit station' do
    expect(subject.exit_station=station).to eq(subject.exit_station)
  end

  describe '#in_journey' do

    it 'checks for a complete journey' do
      expect(subject).not_to be_in_journey #RSpec predicate matcher test, adds ?
      # expect(subject.in_journey?).to be false
    end

    it 'checks for no exit station' do
      journey = Journey.new("Peckham Rye", nil)
      expect(journey).to be_in_journey
    end

    it 'checks for no entry station' do
      journey = Journey.new(nil, "Shoreditch")
      expect(journey).to_not be_in_journey
    end
  end

end
