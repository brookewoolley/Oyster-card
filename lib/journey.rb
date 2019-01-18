class Journey

  MIN_FARE = 1
  PENALTY_FARE = 6

  attr_reader :entry_station
  attr_accessor :exit_station

  def initialize(entry_station, exit_station)
    @entry_station = entry_station
    @exit_station = exit_station
    @journey = {entry: entry_station, exit: exit_station}
  end

  def in_journey?
    @exit_station == nil
  end

  def fare
    # if penalty?     kept for understanding.
    #   PENALTY_FARE
    # else
    #   MIN_FARE
    # end
    return PENALTY_FARE if penalty?
    MIN_FARE
  end

  def penalty?
    return true if entry_station == nil
    return true if exit_station == nil
    # if entry_station == nil || exit_station == nil
    #   true
    # else
    #   false
    # end
  end

end
