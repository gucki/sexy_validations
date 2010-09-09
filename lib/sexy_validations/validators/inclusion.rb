# encoding: utf-8
module SexyValidations
  module Validators
    class Inclusion
      def self.validate(model, attribute, value, options)
        return unless value

        unless options.is_a?(Hash)
          options = {
            :within => options,
          }
        end

        unless options[:within].include?(value)
          model.errors.add(attribute, options[:message] || "ungültige Auswahl")
        end
      end
    end
  end
end

