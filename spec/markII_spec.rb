require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
describe 'Minisculus::Part 2::Mark II' do
    describe "The machine" do
      it "is a MarkII" do
        encoding_machine = setup_MARK_II
        encoding_machine.should be_a Minisculus::MarkII
      end

      it "is an upgraded version of the MarkI" do
        encoding_machine = setup_MARK_II
        Minisculus::MarkII.should < Minisculus::MarkI
      end

      it "has a second encoder wheel" do
        encoding_machine = Minisculus::MarkII.new
        encoding_machine.wheel(2).should_not be_nil
      end

      context "encodes by subtracting two times the value of wheel2 from the value of wheel1" do
        context "so it should encode" do
          it "abc to STU if wheels are set to 2,5" do
            encoding_machine = setup_MARK_II(2,5)
            encoding_machine.encode("abc").should == "STU"
          end

          it "1 to ! for wheels 1,3" do
            encoding_machine = setup_MARK_II(1,3)
            encoding_machine.encode("1").should == "!"
          end
        end
      end

      context "can find the answer to PART 2" do
        it "by encoding 'The Desert Fox will move 30 tanks to Calais at dawn'" do
          encoding_machine = setup_MARK_II(9,3)
          encoding_machine.encode("The Desert Fox will move 30 tanks to Calais at dawn").should == "Wkh2Ghvhuw2Ir.2zloo2pryh2632wdqnv2wr2Fdodlv2dw2gdzq"
        end
      end
    end
end
