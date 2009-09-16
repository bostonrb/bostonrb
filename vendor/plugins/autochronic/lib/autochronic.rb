require 'activerecord'
require 'chronic'

class ActiveRecord::ConnectionAdapters::Column
  class << self
    def string_to_date_with_chronic(string)
      result = string_to_date_without_chronic(string)
      return result if result
      
      parsed = Chronic.parse(string)
      parsed and parsed.to_date
    end
    alias_method_chain :string_to_date, :chronic
    
    def string_to_time_with_chronic(string)
      result = string_to_time_without_chronic(string)
      return result if result
      
      Chronic.parse(string)
    end
    alias_method_chain :string_to_time, :chronic
  end
end
