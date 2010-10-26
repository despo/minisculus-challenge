module Minisculus
  class Validator 
    MATCHES = {
      "symbols inbetween_characters" =>  /[A-Za-z0-9]{1}[!',?\".]{1}[A-Za-z0-9]{1}/,
      "repeated punctuation" => /[(,.|?,|..|.!|!.|!!|,,|.,)]{2}/,
      "numbers between letters" => /[A-Za-z][0-9]{1}[A-Za-z]/
    }
    NO_MATCHES = { "space" => /[\s]/ }

    MAX_SCORE = MATCHES.length

    def is_message_valid?(decoded_message)
      score = MAX_SCORE
      MATCHES.each_value do |regex|
        score = score - 1 if decoded_message.match regex
      end
      NO_MATCHES.each_value do |regex|
        score = score-1 if !decoded_message.match regex
      end
      message_score(score)
    end

    def message_score(score)
      score > MAX_SCORE/2
    end

    def get_valid_wheel_positions_for(message)
      valid_positions = []
      for wheel1 in Wheel::RANGE
        for wheel2 in Wheel::RANGE
          markIV = MarkIV.new
          markIV.wheel(1).set_value(wheel1)
          markIV.wheel(2).set_value(wheel2)
          decoded_message = markIV.decode(message)
          valid_positions << [wheel1,wheel2] if is_message_valid?(decoded_message)
        end
      end
      valid_positions
    end

  end
end
