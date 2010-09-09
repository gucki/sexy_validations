# encoding: utf-8
module SexyValidations
  module Validators
    class Confirmation
      def self.validate(model, attribute, value, options)
        return unless value

        if value != model.send("#{attribute}_confirmation")
          model.errors.add(attribute, "stimmt nicht mit der Bestätigung überein")
        end
      end
    end
  end
end

