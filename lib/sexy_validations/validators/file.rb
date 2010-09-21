# encoding: utf-8
module SexyValidations
  module Validators
    class File
      def self.humanized_size(num)
        for x in ['Byte','KB','MB','GB','TB']
          return "%d %s"%[num, x] if num < 1024.0
          num /= 1024.0
        end
      end

      def self.file_from_value(value)
        case value.class.name
          when "File", "Tempfile"
            value
          when "Sequel::Plugins::Paperclip::Attachment"
            value.queued_file
          else
            raise ArgumentError, "#{value} is not a valid input"
        end
      end

      def self.validate(model, attribute, value, options)
        return unless value

        unless options.is_a?(Hash)
          options = {
            :size => options,
          }
        end

        file = file_from_value(value)
        return unless file

        if options[:size]
          min = options[:size].min
          if file.size < min
            model.errors.add(attribute, "zu klein (mindestes #{humanized_size(min)})")
          end

          max = options[:size].max
          if file.size > max
            model.errors.add(attribute, "zu groß (maximal #{humanized_size(max)})")
          end
        end

      end
    end
  end
end

