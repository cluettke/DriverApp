#define class Family
require 'csv'

class Family
    @primary_insured_id = nil
    @contract_effective_date = nil

    def load_family_preferences (preferences) 
        str = CSV.read(preferences, headers: true)
        @brush_preferences = Array.new
        @family_data = Array.new
        CSV.foreach(preferences, headers:true) do |row|  
            family_member = Array.new(5)
            # CSV in format: id, name, brush_color, primary_insured_id, contract_effective_date
            family_member[0] = row[0]
            family_member[1] = row[1]
            family_member[2] = row[2]
            brush_color = row[2]
            @brush_preferences.push(brush_color)
            family_member[3] = row[3]
            family_member[4] = row[4]

            if @primary_insured_id == nil && row[3] != nil then
                @primary_insured_id = row[3]
            end

            if @contract_effective_date == nil && row[4] != nil then
                @contract_effective_date = row[4]
            end

            @family_data.push(family_member)
        end
        return get_brush_preferences()
    end



    def get_brush_preferences
        if @brush_preferences != nil then
            return @brush_preferences.inject(Hash.new(0)) { |total, e| total[e] += 1; total}
        else 
            return nil
        end
    end

    def get_primary_insured_id
        return @primary_insured_id
    end

    def get_contract_effective_date
        return @contract_effective_date
    end

    def get_family_data
        return @family_data
    end
end