module Minisculus
  class MarkII < MarkI
    def initialize
      @wheel = { 1 => Wheel.new, 2 => Wheel.new }
    end

    def wheel(number)
      @wheel[number]
    end
    
    private
      def encoding_algorithm
         wheel(1).value - 2*wheel(2).value
      end
  end
end
