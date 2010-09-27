require 'sexy_validations/errors'

module SexyValidations
  def self.load_validator(name)
    require "sexy_validations/validators/#{name}"
    "SexyValidations::Validators::#{name.to_s.capitalize}".constantize
  end

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
      SexyValidations.load_validator(name)
    end
    
    def validates(attribute = nil, validations = nil, &block)
      condition = nil

      if validations
        if validations[:if]
          condition = validations.delete(:if)
        end

        if validations[:unless]
          raise ArgumentError, "if and unless condition given" if condition
          ref = validations.delete(:unless)
          condition = lambda { |model| !ref.call(model) }
        end
      end

      unless validations.blank?
        validations.each_pair do |validator, options|
          klass = load_validator(validator)
          self.validations << {
            :attribute => attribute,
            :validator => klass,
            :options => options,
            :condition => condition,
          }
        end
      else
        if attribute
          self.validations << {
            :method => "#{attribute}_validation",
            :condition => condition,
          }
        else
          raise ArgumentError, "at least a block has to be given" unless block_given?
          self.validations << {
            :block => block,
            :condition => condition,
          }
        end
      end
    end
  end

  module InstanceMethods
    def validate!
      errors.clear     
      validations.each do |validation|
        if validation[:condition]
          next unless validation[:condition].call(self) 
        end

        case
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

