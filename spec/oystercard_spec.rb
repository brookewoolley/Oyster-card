require 'oystercard'

describe Oystercard do
  let(:station) {double('entry_station')}
  let(:exit_station) {double('exit_station')}

  describe '#top_up' do


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

  end

  describe '#in_journey' do

    it 'checks whether card holder is in journey' do
      expect(subject).not_to be_in_journey #RSpec predicate matcher test, adds ?
      # expect(subject.in_journey?).to be false
    end

    it 'touch in to start journey' do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject).to be_in_journey
      # expect{subject.touch_in}.to change{ subject.in_journey? }.to eq true
    end

  end

  describe '#touch_in' do

    it 'raises an error at touch in when minimum balance not available' do
      # subject.balance(0)
      expect{subject.touch_in(station)}.to raise_error "Please top up: minimum balance not available for journey"
    end

    it 'records the entry station at touch_in' do
      subject.top_up(5)
      expect{subject.touch_in(station)}.to change{ subject.journey[:entry] }.to eq station
    end

  end

  describe '#touch_out' do

    it 'touch out to end journey' do
      subject.top_up(5)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
      # expect{card.touch_out}.to change{ card.in_journey? }.to eq false
    end

    it 'deducts fare on touch_out' do
      expect{subject.touch_out(station)}.to change{ subject.balance }.by -Oystercard::FARE
    end

    it 'forgets entry station on touch out' do
      subject.top_up(5)
      subject.touch_in(station)
      expect{subject.touch_out(station)}.to change{subject.entry_station}.to nil
    end

    it 'records the exit station at touch out' do
      subject.top_up(5)
      subject.touch_in(station)
      expect{subject.touch_out(station)}.to change{ subject.journey[:exit]}.to eq station
    end

  end

  describe 'record of journeys' do

    it 'gives a list of journeys' do
      expect(subject.list_journeys).to be_empty
    end

    it 'touching in and out creates one journey' do
      subject.top_up(5)
      expect{subject.touch_in(station)}.to change{ subject.entry_station }.to eql station
      # subject.touch_out(exit_station)
      # expect(subject.list_journeys).to eq ({entry: station, exit: exit_station})

    end

  end

end
