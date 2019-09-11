require 'boxing/kata/family'

#define class Box Scheduler
class BoxScheduler    
    
    def ship_starter_box(family_data)
        bursh_preferences = family_data.get_brush_preferences
        brushes_in_box = 0
        if bursh_preferences != nil then
            starter_box_str = ""
            bursh_preferences.each do |preference|
                while preference[1] > 0 do

                    if brushes_in_box == 0 then
                        starter_box_str << "STARTER BOX\n"

                        if preference[1] >= 2 then
                            starter_box_str <<
                            "2 " << preference[0] << " brushes\n" <<
                            "2 " << preference[0] << " replacement heads\n"
                            preference[1] -= 2
                        else
                            starter_box_str <<
                            "1 " << preference[0] << " brush\n" <<
                            "1 " << preference[0] << " replacement head\n"
                            preference[1] -= 1
                            brushes_in_box += 1
                        end
                    else #Already one brush in box
                        starter_box_str <<
                        "1 " << preference[0] << " brush\n" <<
                        "1 " << preference[0] << " replacement head\n"
                        preference[1] -= 1
                        brushes_in_box += 1
                    end
                    
                    if brushes_in_box == 2 then
                        brushes_in_box = 0
                    end
                end
            end
            return starter_box_str
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