module Minisculus
  class Wheel
    RANGE = 0..9

    def value
      @value
    end

    def set_value(value)
      if RANGE === (value)  
        @value = value
      else
        raise(ArgumentError, "Number not in valid range")
      end
    end
  end

  class InnerWheel < Wheel
    def set_value(value)
      raise(ArgumentError, "Not a valid number #{value}") unless value.is_a? Integer
      @value = value
    end 

    def reset
      @value = 0
    end
  end
end
