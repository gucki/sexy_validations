module SexyValidations
  class Errors < ::Hash
    def [](k)
      has_key?(k) ? super : (self[k] = [])
    end

    def add(att, msg)
      self[att] << msg
    end

    def count
      values.inject(0){ |m, v| m+v.length }
    end
       
    def empty?
      count == 0
    end
  end
end

