#define class Family
require 'csv'

class Family
    @brush_preferences = Array.new
    @primary_insured_id = 0
    @contract_effective_date = 0

    def load_family_preferences (preferences) 
        str = CSV.read(preferences, headers: true)
        @family_data = Array.new
        CSV.foreach(preferences, headers:true) do |row|  
            family_member = Array.new(5)
            family_member[0] = row[0]
            family_member[1] = row[1]
            family_member[2] = row[2]
            family_member[3] = row[3]
            family_member[4] = row[4]
            @family_data.push(family_member)
        end
    end

    def get_brush_preferences
        return @brush_preferences
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