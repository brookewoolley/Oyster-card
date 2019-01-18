require_relative 'journey'

class Oystercard

  MINIMUM_BALANCE = 1
  MAXIMUM_BALANCE = 90
  FARE = 1

  attr_reader :balance, :list_journeys

  def initialize
    @balance = 0
    @list_journeys = []
  end

  def top_up(amount)
    fail "Unable to top-up, balance can not exceed #{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  # def in_journey?
  #   @entry_station != nil
  # end

  def touch_in(entry_station)
    fail "Please top up: minimum balance not available for journey" if @balance < MINIMUM_BALANCE
    journey = Journey.new(entry_station, nil)
    @list_journeys.push(journey) #this pushes the journey instance (ie a journey onject that contains amongst other things a record of our entry station) to our array (list_journey)
  end

  def touch_out(exit_station)
    deduct(FARE)
    journey = @list_journeys.last
    journey
  end

private

  def deduct(amount)
    @balance -= amount
  end



end
