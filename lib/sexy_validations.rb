require 'sexy_validations/errors'

module SexyValidations
  def self.included(klass)
    klass.instance_eval do
      class_inheritable_array :validations
      self.validations = []

      extend  ClassMethods
      include InstanceMethods

      unless method_defined?(:errors)
        class_eval do
          def errors
            @errors ||= Errors.new
          end
        end
      end

      unless method_defined?(:valid?)
        class_eval do
          def valid?
            validate!
            errors.empty?
          end
        end
      end
    end
  end

  module ClassMethods
    def load_validator(name)
      require "sexy_validations/validators/#{name}"
      "SexyValidations::Validators::#{name.to_s.capitalize}".constantize
    end

    def validates(attribute = nil, validations = nil, &block)
      if validations
        validations.each_pair do |validator, options|
          klass = load_validator(validator)
          self.validations << {
            :attribute => attribute,
            :validator => klass,
            :options => options,
          }
        end
      else
        if attribute
          self.validations << {
            :method => "#{attribute}_validation",
          }
        else
          self.validations << {
            :block => block,
          }
        end
      end
    end
  end

  module InstanceMethods
    def validate!
      errors.clear     
      validations.each do |validation|
        valid = case
          when validation[:validator]
            if errors[validation[:attribute]].empty?
              validation[:validator].validate(self, validation[:attribute], send(validation[:attribute]), validation[:options])
            end
          when validation[:method]
            send(validation[:method])
          when validation[:block]
            validation[:block].call
          else
            raise ArgumentError, "invalid validation (internal error)"
        end
      end
    end
  end
end

