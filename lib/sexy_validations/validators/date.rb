# encoding: utf-8
module SexyValidations
  module Validators
    class Date
      def self.validate(record, attribute, value, options)
        return unless value
     
        if value.is_a?(::Date) || value.is_a?(::Time)
          if options.is_a?(Hash)
            min = options[:within].min
            if value < min
              record.errors.add(attribute, "zu früh (frühestens #{min})")
            end

            max = options[:within].max
            if value > max
              record.errors.add(attribute, "zu spät (spätestens #{max})")
            end
          end
        else
          record.errors.add(attribute, "ungültig")
        end
      end
    end
  end
end

