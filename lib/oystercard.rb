class Oystercard

  MINIMUM_BALANCE = 1
  MAXIMUM_BALANCE = 90
  FARE = 1

  attr_reader :balance, :entry_station, :journey, :list_journeys

  def initialize
    @balance = 0
    @list_journeys = {}
    @journey = {}
    @entry_station
  end

  def top_up(amount)
    fail "Unable to top-up, balance can not exceed #{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(entry_station)
    fail "Please top up: minimum balance not available for journey" if @balance < MINIMUM_BALANCE
    @journey[:entry] = entry_station #this pushes the key (entry) and value (entry_station) to hash
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    @entry_station = nil
    deduct(FARE)
    @journey[:exit] = exit_station
    @list_journeys[Time.now] = @journey
  end

private

  def deduct(amount)
    @balance -= amount
  end


end
