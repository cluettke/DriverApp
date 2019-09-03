require 'boxing/kata/family'

#define class Box Scheduler
class BoxScheduler
    
    def load_family_preferences(preferences)
    end

    def compute_refill_dates(effective_date)
        refill_dates = Array.new(4, Date.new)
        effective_date.to_s
        refill_interval = 90
        refill_dates[0] = effective_date + refill_interval
        refill_dates[1] = refill_dates[0] + refill_interval
        refill_dates[2] = refill_dates[1] + refill_interval
        refill_dates[3] = refill_dates[2] + refill_interval
        return refill_dates
    end
end