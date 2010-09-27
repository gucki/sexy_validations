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
        
        data = case options[:within]
          when Proc
            options[:within].call(model)
          else
            options[:within]
        end

        unless data.include?(value)
          model.errors.add(attribute, options[:message] || "ungültige Auswahl")
        end
      end
    end
  end
end

