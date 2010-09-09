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

        min = options[:within].min
        if value.calc_age < min
          record.errors.add(attribute, "ungültig (mindestes #{min} Jahre)")
        end

        max = options[:within].max
        if value.calc_age > max
          record.errors.add(attribute, "ungültig (maximal #{max} Jahre)")
        end
      end
    end
  end
end

