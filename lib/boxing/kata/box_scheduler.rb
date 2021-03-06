require 'boxing/kata/family'

#define class Box Scheduler
class BoxScheduler    
    @has_starter_box_shipped = false

    def ship_starter_box(family_data)
        bursh_preferences = family_data.get_brush_preferences
        brushes_in_box = 0
        if bursh_preferences != nil then
            starter_box_str = ""
            bursh_preferences.each do |preference|
                while preference[1] > 0 do

                    if brushes_in_box == 0 then
                        starter_box_str << "\nSTARTER BOX\n"

                        if preference[1] >= 2 then
                            starter_box_str <<
                            "2 " << preference[0] << " brushes\n" <<
                            "2 " << preference[0] << " replacement heads\n" <<
                            "2 paste kits\n"
                            preference[1] -= 2
                            brushes_in_box = 2
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
                        "1 " << preference[0] << " replacement head\n" <<
                        "2 paste kits\n"
                        preference[1] -= 1
                        brushes_in_box += 1
                    end
                    
                    if brushes_in_box == 2 then
                        starter_box_str << "Schedule: " << family_data.get_contract_effective_date() << "\n"
                        starter_box_str << "Mail Class: " << calculate_shipping_method(2, 2, 2) << "\n"
                        brushes_in_box = 0
                    end
                end
            end
            if brushes_in_box == 1 then
                starter_box_str << "1 paste kit\n"
                starter_box_str << "Schedule: " << family_data.get_contract_effective_date() << "\n"
                starter_box_str << "Mail Class: " << calculate_shipping_method(1, 1, 1) << "\n"
            end
            @has_starter_box_shipped = true
            return starter_box_str
        else
            return "NO STARTER BOXES GENERATED\n"
        end
    end

    def ship_refill_boxes(family_data)
        if (!@has_starter_box_shipped) then
           return "NO STARTER BOXES GENERATED\n" 
        end
        bursh_preferences = family_data.get_brush_preferences
        items_in_box = 0
        if bursh_preferences != nil then
            refill_box_str = ""
            effective_date = Date.parse(family_data.get_contract_effective_date())
            bursh_preferences.each do |preference|
                while preference[1] > 0 do

                    if items_in_box == 0 then
                        refill_box_str << "\nREFILL BOX\n"
                    end

                    space_left = 4 - items_in_box
                    if preference[1] == 1 || space_left == 1 then
                        refill_box_str << 
                        "1 " << preference[0] << " replacement head\n"
                        items_in_box += 1
                        preference[1] -= 1
                    else
                        if preference[1] <= space_left then
                            refill_box_str <<
                            preference[1].to_s << " " << preference[0] << " replacement heads\n"
                            items_in_box += preference[1]
                            preference[1] -= preference[1]
                        else
                            refill_box_str <<
                            space_left.to_s << " " << preference[0] << " replacement heads\n"
                            items_in_box += space_left
                            preference[1] -= space_left
                        end
                    end
                    
                    if items_in_box == 4 then
                        refill_box_str << "4 paste kits\n"
                        refill_box_str << print_refill_dates(effective_date)
                        refill_box_str << "Mail Class: " << calculate_shipping_method(0, 4, 4) << "\n"
                        items_in_box = 0
                    end
                end
            end
            if items_in_box != 0 then
                refill_box_str << items_in_box.to_s << " paste kit\n"
                refill_box_str << print_refill_dates(effective_date)
                refill_box_str << "Mail Class: " << calculate_shipping_method(0, items_in_box, items_in_box) << "\n"
            end
            return refill_box_str
        else
            return "PLEASE LOAD USER PREFERENCES\n"
        end
    end

    def print_refill_dates(effective_date)
        refill_dates = compute_refill_dates(effective_date)
        refill_dates_str = "Schedule: " << refill_dates[0].to_s << ", " << 
                        refill_dates[1].to_s << ", " <<
                        refill_dates[2].to_s << ", " <<
                        refill_dates[3].to_s << "\n"
        return refill_dates_str
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

    def calculate_shipping_method(num_brushes, num_brush_heads, num_paste_kits) 
        brush_wgt = 9
        brush_head_wgt = 1
        paste_kit_wgt = 7.6
        first_class_wgt_limit = 16
        shipping_weight = 0.0
        shipping_weight = num_brushes * brush_wgt + num_brush_heads * brush_head_wgt +
                          num_paste_kits * paste_kit_wgt
        
        if shipping_weight < first_class_wgt_limit then
            return "first"
        else
            return "priority"
        end
    end
end