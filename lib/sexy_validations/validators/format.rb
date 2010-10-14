# encoding: utf-8
module SexyValidations
  module Validators
    class Format
      def self.validate(model, attribute, value, options)
        return if value.blank?

        unless options.is_a?(Hash)
          options = {
            :with => options,
          }
        end

        unless value =~ options[:with]
          model.errors.add(attribute, options[:message] || "ungültiges Format")
        end
      end
    end
  end
end

