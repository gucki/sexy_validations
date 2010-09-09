# encoding: utf-8
module SexyValidations
  module Validators
    class Length
      def self.validate(model, attribute, value, options)
        return unless value

        unless options.is_a?(Hash)
          options = {
            :within => options,
          }
        end

        min = options[:within].min
        if value.length < min
          model.errors.add(attribute, "zu kurz (mindestens #{min} Zeichen)")
        end

        max = options[:within].max
        if value.length > max
          model.errors.add(attribute, "zu lang (maximal #{max} Zeichen)")
        end
      end
    end
  end
end

