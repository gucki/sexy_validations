# encoding: utf-8
module SexyValidations
  module Validators
    class Email
      REGEXP = /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

      def self.validate(record, attribute, value, options)
        return if value.blank?

        unless value =~ REGEXP
          record.errors.add(attribute, "ungültiges Format")
        end
      end
    end
  end
end

