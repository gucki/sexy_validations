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

      def self.validate(model, attribute, value, options)
        return unless value

        unless options.is_a?(Hash)
          options = {
            :size => options,
          }
        end

        unless value.is_a?(File) || value.is_a?(Tempfile)
          raise ArgumentError, "#{value} is not a File"
        end

        if options[:size]
          min = options[:size].min
          if value.size < min
            model.errors.add(attribute, "zu klein (mindestes #{humanized_size(min)})")
          end

          max = options[:size].max
          if value.size > max
            model.errors.add(attribute, "zu groß (maximal #{humanized_size(max)})")
          end
        end

      end
    end
  end
end

