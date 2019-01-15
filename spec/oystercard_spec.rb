require 'oystercard'

describe Oystercard do

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

  it 'deducts a fare' do
    expect(subject).to respond_to(:deduct).with(1).argument
  end

  it 'deducts fare amount from balance' do
    # card = Oystercard.new
    # card.deduct(5)
    expect{ subject.deduct 3}.to change{ subject.balance }.by -3
  end

  it 'checks whether card holder is in journey' do
    expect(subject).not_to be_in_journey #RSpec predicate matcher test, adds ?
    # expect(subject.in_journey?).to be false
  end

  it 'touch in to start journey' do
    subject.touch_in
    expect(subject).to be_in_journey
    # expect{subject.touch_in}.to change{ subject.in_journey? }.to eq true
  end

  it 'touch out to end journey' do
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
    # expect{card.touch_out}.to change{ card.in_journey? }.to eq false
  end

end
