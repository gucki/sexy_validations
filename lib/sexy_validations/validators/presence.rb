# encoding: utf-8
module SexyValidations
  module Validators
    class Presence
      def self.validate(model, attribute, value, options)
        return unless value.blank?

        model.errors.add(attribute, "muss ausgefüllt werden")
      end
    end
  end
end

