class Oystercard

  MAXIMUM_BALANCE = 90

  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
  fail "Unable to top-up, balance can not exceed #{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
  @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "Please top up: minimum balance not available for journey" if @balance < 1
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end
