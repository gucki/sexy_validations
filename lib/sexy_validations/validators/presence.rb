# encoding: utf-8
module SexyValidations
  module Validators
    class Presence
      def self.validate(model, attribute, value, options)
        real_value = case value.class.name
          when "Sequel::Plugins::Paperclip::Attachment"
            value.queued_file
          else
            value
        end

        return unless real_value.blank?

        model.errors.add(attribute, "muss ausgefüllt werden")
      end
    end
  end
end

