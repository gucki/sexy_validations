# encoding: utf-8
module SexyValidations
  module Validators
    class Age
      def self.validate(record, attribute, value, options)
        return unless value

        unless options.is_a?(Hash)
          options = {
            :within => options,
          }
        end

        if value.is_a?(::Date)
          min = options[:within].min
          if value.calc_age < min
            record.errors.add(attribute, "zu jung (mindestes #{min} Jahre)")
          end

          max = options[:within].max
          if value.calc_age > max
            record.errors.add(attribute, "zu alt (maximal #{max} Jahre)")
          end
        else
          record.errors.add(attribute, "ungültig")        
        end          
      end
    end
  end
end

