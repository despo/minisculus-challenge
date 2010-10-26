require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
  describe "PART V: The Validator" do
      describe "validates a message that contains" do
        it "only alphabetic characters" do
          is_message_valid?("The white cliffs of Alghero are visible at night").should be_true
        end
      
        it "symbols inbetween letters" do
          is_message_valid?("The rockets will strike at coordinates 49.977984 7.9257857 422979.83 5536735.81 on Oct. 7th").should be_true
        end

        describe "repeated punctuation characters" do
          it "like .." do
            is_message_valid?("This looks valid...").should be_true
          end

          it "or .!" do
            is_message_valid?("Something like this.!").should be_true
          end
        end

        it "letters mixed up with numbers" do
          is_message_valid?("The Desert Fox will move 30 tanks to Calais at dawn").should be_true
        end
      end

      describe "invalides a message if it finds" do
        it "both numbers and repeated punctuation characters" do
          is_message_valid?("l9t\"Wk4hs2yYTtH0vwUZp4a\"WhB2u").should be_false
        end
        
        it "both symbols and numbers between letters" do
          is_message_valid?("4k0qA'2nEqhtAQmyilpov2doVr!xWSkEDn?,iZpw").should be_false
        end
    end

    context "find all the valid wheel positions that can decode a mesasge" do
      it "for JMl0kBp?20Qixoiv to The white cliffs the wheels are set to 4 and 7" do
        get_valid_wheel_positions_for("JMl0kBp?20Qixoiv").should include [4,7]
      end

      it "'WZyDsL3u'0TfxP06RtSSF ' is decoded to The rockets will strike when the wheels are set to 7,2" do
        get_valid_wheel_positions_for("WZyDsL3u'0TfxP06RtSSF '").should include [7,2]
        #include [7,2]
      end
    end
    
  context "it can find all wheel positions that can decoded the final question" do
    before (:all) do
      @message = "QT4e8MJYVhkls.27BL9,.MSqYSi'IUpAJKWg9Ul9p4o8oUoGy'ITd4d0AJVsLQp4kKJB2rz4dxfahwUa\"Wa.MS!k4hs2yY3k8ymnla.MOTxJ6wBM7sC0srXmyAAMl9t\"Wk4hs2yYTtH0vwUZp4a\"WhB2u,o6.!8Zt\"Wf,,eh5tk8WXv9UoM99w2Vr4!.xqA,5MSpWl9p4kJ2oUg'6evkEiQhC'd5d4k0qA'24nEqhtAQmy37il9p4o8vdoVr!xWSkEDn?,iZpw24kF\"fhGJZMI8nkI"
      @wheel_positions = get_valid_wheel_positions_for(@message)
    end

    it "there is more than one possible solution" do
      @wheel_positions.size.should > 1
    end

    it "all the decoded messages are the same" do
      decoded_messages = []
      @wheel_positions.each do | wheel1, wheel2 |
        encoding_machine = setup_MARK_IV(wheel1, wheel2)
        decoded_messages << encoding_machine.decode(@message)
      end
      decoded_messages.uniq.length.should == 1
    end
    
    it "they contain the words FURLIN" do
      encoding_machine = setup_MARK_IV(@wheel_positions[0][0],@wheel_positions[0][1])
      encoding_machine.decode(@message).should include 'FURLIN'
    end

    it "and BUNKER" do
      encoding_machine = setup_MARK_IV(@wheel_positions[0][0], @wheel_positions[0][1])
      encoding_machine.decode(@message).should include 'BUNKER'
    end
  end
end

def is_message_valid?(message)
  validator = Minisculus::Validator.new
  validator.is_message_valid?(message)
end

def get_valid_wheel_positions_for(encoded_message)
  validator = Minisculus::Validator.new
  validator.get_valid_wheel_positions_for(encoded_message)
end

