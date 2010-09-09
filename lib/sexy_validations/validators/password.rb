# encoding: utf-8
module SexyValidations
  module Validators
    class Password
      def self.validate(record, attribute, value, options)
        return unless value

        unless options.is_a?(Hash)
          options = {}
        end

        options[:length] ||= 6..20
        options[:format] ||= /^[\x20-\x7e]+$/i

        min = options[:length].min
        if value.length < min
          record.errors.add(attribute, "zu kurz (mindestes #{min} Zeichen)")
        end

        max = options[:length].max
        if value.length > max
          record.errors.add(attribute, "zu lang (maximal #{max} Zeichen)")
        end

        unless value =~ options[:format]
          record.errors.add(attribute, "enthält ungültige Zeichen")
        end
      end
    end
  end
end

