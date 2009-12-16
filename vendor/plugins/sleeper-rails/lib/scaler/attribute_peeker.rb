### AR object lifecycle:
# columns loaded
# columns read / written
# gc'ed

module Scaler
  module AttributePeeker
	mattr_accessor :enabled

	def self.enable!; @@enabled=true; end
	def self.disable!; @@enabled=false; end
    
  # include this to ActiveRecord::Base
  def self.included(base)
    Scaler.log(:peeker, Logger::DEBUG) { "EXTENDING AR::Base" }
		
		ActiveRecord::AttributeMethods::ClassMethods.alias_method_chain :define_read_method, :logging
		
		ActiveRecord::Base.class_eval("
				class << self
					alias_method_chain :find_by_sql, :logging
				end
			")
  end
    
  end
end

module ActiveRecord
	class Base
		def self.find_by_sql_with_logging(record)
			results = find_by_sql_without_logging(record)
			results.each{|r|
				attributes = r.instance_variable_get("@attributes").collect{|k,v| k }
				
				# TODO: TRANSACT
				
				loads = Scaler.statistics.request_key(:activerecord_loads) || {}
				loads[r.object_id] = { :class=>r.class.to_s, :attributes => attributes, :location => Scaler.sanitize_callback(caller)[0..(Scaler.config?(:trace_depth))] }
				Scaler.statistics.set_request_key(:activerecord_loads,loads)
				
				# TODO: END TRANSACT
			
			}
			results
		end
	end
end

module ActiveRecord::AttributeMethods
	module ClassMethods
		def define_read_method_with_logging(symbol, attr_name, column)
			define_read_method_without_logging(symbol, attr_name, column)

			logging_code = "def #{attr_name}_with_logging; read_attribute_with_logging('#{attr_name}'); #{attr_name}_without_logging; end"
			chain_code = "alias_method_chain :#{attr_name},:logging"
			
			class_eval(logging_code)
			class_eval(chain_code)
	 end
	end

  def read_attribute_with_logging(name)
	
				# TODO: TRANSACT
					
		 loads = Scaler.statistics.request_key(:activerecord_loads) || {}
		
     if loads[self.object_id] then
			 loads[self.object_id][:read_attributes] = [name] unless loads[self.object_id][:read_attributes]
			 loads[self.object_id][:read_attributes] << name if loads[self.object_id][:read_attributes]
			 loads[self.object_id][:read_attributes].uniq!
			 Scaler.statistics.set_request_key(:activerecord_loads,loads)
		 end
		
		 
		# TODO: END TRANSACT
		
   end

end