require 'oystercard'

describe Oystercard do
  let(:aldgate) {double('entry_station')}

  it 'returns the current balance' do
    expect(subject.balance).to eq (0)
  end

  it 'can be topped up' do
    expect(subject).to respond_to(:top_up).with(1).argument
  end

  it 'returns the updated balance after top up' do
    card = Oystercard.new
    card.top_up(5)
    expect(card.balance).to eq (5)
    # mocked_balance = double(subject.balance)
    # allow(mocked_balance).to receive(subject.top_up(5)).and_return(5)
  end

  it 'raises an error when topping up if balance will exceed £90' do
    subject.top_up(Oystercard::MAXIMUM_BALANCE)
    expect{subject.top_up(1)}.to raise_error "Unable to top-up, balance can not exceed #{Oystercard::MAXIMUM_BALANCE}"
  end

  it 'checks whether card holder is in journey' do
    expect(subject).not_to be_in_journey #RSpec predicate matcher test, adds ?
    # expect(subject.in_journey?).to be false
  end

  it 'touch in to start journey' do
    subject.top_up(5)
    subject.touch_in(aldgate)
    expect(subject).to be_in_journey
    # expect{subject.touch_in}.to change{ subject.in_journey? }.to eq true
  end

  it 'raises an error at touch in when minimum balance not available' do
    # subject.balance(0)
    expect{subject.touch_in(aldgate)}.to raise_error "Please top up: minimum balance not available for journey"
  end

  it 'touch out to end journey' do
    subject.top_up(5)
    subject.touch_in(aldgate)
    subject.touch_out
    expect(subject).not_to be_in_journey
    # expect{card.touch_out}.to change{ card.in_journey? }.to eq false
  end

  it 'deducts fare on touch_out' do
    expect{subject.touch_out}.to change{ subject.balance }.by -Oystercard::FARE
  end

  it 'records the entry station at touch_in' do
    subject.top_up(5)
    expect{subject.touch_in(aldgate)}.to change{ subject.entry_station }.to aldgate
  end

  it 'forgets entry station on touch out' do
    subject.top_up(5)
    subject.touch_in(aldgate)
    expect{subject.touch_out}.to change{subject.entry_station}.to nil
  end

end
