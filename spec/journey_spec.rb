require 'journey'

describe Journey do

  subject {described_class.new("Peckham Rye", "Shoreditch")}

  it 'knows the entry entry_station' do
    expect(subject.entry_station).to eq("Peckham Rye")
  end

  it 'knows the exit station' do
    expect(subject.exit_station).to eq("Shoreditch")
  end

end
