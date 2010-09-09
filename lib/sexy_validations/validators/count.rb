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

