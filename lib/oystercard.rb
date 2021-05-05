class Oystercard

    MAX_LIMIT = 90
    MIN_LIMIT = 1
    MIN_FARE = 1

    attr_reader :balance
    attr_reader :entry_station
    attr_reader :exit_station
    attr_reader :journeys

    def initialize
        @balance = 0
        @entry_station = nil
        @exit_station = nil
        @journeys = []
    end

    def top_up(value)
        fail "Your oystercard has reached its limit of £#{MAX_LIMIT}" if limit?
        @balance += value
    end

    def touch_in(station)
        fail "Your oystercard has insufficient funds" if minimum?
        @entry_station = station
    end

    def touch_out(station)
        @exit_station = station
        record_journey
        @entry_station = nil
        @exit_station = nil
        deduct(MIN_FARE)
    end

    def in_journey?
        !!entry_station
    end

    def record_journey
        @journeys << { entry: @entry_station, exit: @exit_station }
    end
    
    private

    def limit?
        @balance >= MAX_LIMIT
    end

    def minimum? 
        @balance <= MIN_LIMIT
    end

    def deduct(value)
        @balance -= value
    end
end