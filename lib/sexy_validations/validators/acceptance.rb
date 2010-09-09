# encoding: utf-8
module SexyValidations
  module Validators
    class Acceptance
      def self.validate(model, attribute, value, options)
        unless value.to_i > 0
          model.errors.add(attribute, "muss akzeptiert werden")
        end
      end
    end
  end
end

