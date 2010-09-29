# encoding: utf-8
module SexyValidations
  module Validators
    class Count
      def self.validate(record, attribute, value, options)
        return unless value

        unless options.is_a?(Hash)
          options = {
            :within => options,
          }
        end
        
        case options[:within]
          when Fixnum, Integer, Bignum
            unless value.count == options[:within]
              record.errors.add(attribute, "ungültige Anzahl Selektionen")
            end

          when Array
            unless options[:within].include?(value.count)
              record.errors.add(attribute, "ungültige Anzahl Selektionen")
            end
          
          when Range
            min = options[:within].min
            if value.count < min
              record.errors.add(attribute, "zu wenig Selektionen (mindestes #{min})")
            end

            max = options[:within].max
            if value.count > max
              record.errors.add(attribute, "zu viele Selektionen (maximal #{max})")
            end
        end
      end
    end
  end
end

