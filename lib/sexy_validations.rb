require 'sexy_validations/errors'

module SexyValidations
  def self.load_validator(name)
    require "sexy_validations/validators/#{name}"
    "SexyValidations::Validators::#{name.to_s.camelize}".constantize
  rescue LoadError
    "::#{name.to_s.camelize}Validator".constantize
  end

  def self.included(klass)
    klass.instance_eval do
      class_attribute :validations
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
      conditions = nil
      conditions_if = nil

      if validations
        if validations[:if]
          conditions = validations.delete(:if)
          conditions_if = true
        end

        if validations[:unless]
          raise ArgumentError, "if and unless conditions given" if condition
          conditions = validations.delete(:unless)
          conditions_if = false
        end
        
        conditions = [conditions] if conditions && !conditions.is_a?(Array)
      end

      unless validations.blank?
        validations.each_pair do |validator, options|
          klass = load_validator(validator)
          self.validations += [{
            :attribute => attribute,
            :validator => klass,
            :options => options,
            :conditions => conditions,
            :conditions_if => conditions_if,
          }]
        end
      else
        if attribute
          self.validations += [{
            :method => "#{attribute}_validation",
            :conditions => conditions,
            :conditions_if => conditions_if,
          }]
        else
          raise ArgumentError, "at least a block has to be given" unless block_given?
          self.validations += [{
            :block => block,
            :conditions => conditions,
            :conditions_if => conditions_if,
          }]
        end
      end
    end
  end

  module InstanceMethods
    def validate!
      errors.clear     
      validations.each do |validation|
        catch(:skip_validation) do
          if validation[:conditions]
            validation[:conditions].each do |condition|
              success = condition.call(self, validation[:attribute])
              if validation[:conditions_if] 
                throw :skip_validation unless success
              else
                throw :skip_validation if success
              end
            end
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
end

