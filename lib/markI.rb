module Minisculus
  class MarkI
    KEYBOARD = [
      "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
      "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
      "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
      "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
      "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
      ".", ",", "?", "!", "'", "\"", " "
    ]
    
    def wheel
      @wheel ||= Wheel.new
    end

    def encode(message)
      result = ""
      message.each_char do |character|
        result += apply_encoding_algorithm(character)
      end unless message.empty?
      result
    end

    private
      def apply_encoding_algorithm(character)
        position = KEYBOARD.index(character)+ encoding_algorithm
        keyboard_character_at(position)
      end

      def encoding_algorithm
        wheel.value
      end

      def keyboard_character_at(position)
        position = position % KEYBOARD.length if position <=> KEYBOARD.length
        KEYBOARD[position]
      end
  end
end
