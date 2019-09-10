require 'boxing/kata/family'

#define class Box Scheduler
class BoxScheduler    
    
    def ship_starter_box(family_data)
        bursh_preferences = family_data.get_brush_preferences
        if bursh_preferences != nil then
            for idx in 0..bursh_preferences.length do
                print 'STARTER BOX\n'
            end
        else
            return "NO STARTER BOXES GENERATED\n"
        end
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