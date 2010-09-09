# encoding: utf-8
module SexyValidations
  module Validators
    class Image
      def self.validate(model, attribute, value, options)
        return unless value

        unless options.is_a?(Hash)
          options = {
            :geometry => options,
          }
        end

        unless value.is_a?(File) || value.is_a?(Tempfile)
          raise ArgumentError, "#{value} is not a File"
        end

        if options[:geometry]
          geo1 = Sequel::Plugins::Paperclip::Processors::Image::Geometry.from_s(options[:geometry])
          geo2 = Sequel::Plugins::Paperclip::Processors::Image::Geometry.from_file(value)
          if geo2
            if geo2.width < geo1.width
              model.errors.add(attribute, "zu klein (weniger als %d Pixel breit)"%[geo1.width])
            end
            if geo2.height < geo1.height
              model.errors.add(attribute, "zu klein (weniger als %d Pixel hoch)"%[geo1.height])
            end
          else
            model.errors.add(attribute, "Bildformat unbekannt oder Datei beschädigt")
          end
        end
      end
    end
  end
end

