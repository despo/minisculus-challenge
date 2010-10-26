module Minisculus
  class MarkIV < MarkII
    def initialize
      super
      @wheel[3] = InnerWheel.new
      @wheel[3].reset
    end
    
    def encode(message)
      result = ""
      message.each_char do |character|
        result += apply_encoding_algorithm(character)
        move_third_wheel(character)
      end
      result
    end

    def decode(message)
      result = ""
      message.each_char do |character|
        decoded_character = apply_decoding_algorithm(character)
        move_third_wheel(decoded_character)
        result += decoded_character
      end
      result
    end
    
    private
      def move_third_wheel(character)
        position = KEYBOARD.index(character)*2
        wheel(3).set_value(position)
      end

      def apply_decoding_algorithm(character)
        position = KEYBOARD.index(character) - decoding_algorithm
        keyboard_character_at(position)
      end

      def encoding_algorithm
        super + wheel(3).value
      end

      def decoding_algorithm
        encoding_algorithm
      end
  end
end
