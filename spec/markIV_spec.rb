require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
describe "Minisculus::Part III: Mark IV" do
  it "is a Mark IV" do
    encoding_machine = Minisculus::MarkIV.new
    encoding_machine.should be_a Minisculus::MarkIV
  end
  
  describe "has a third wheel" do
    before(:all) do
      encoding_machine = Minisculus::MarkIV.new
      @wheel3 = encoding_machine.wheel(3)
    end

    it "defaults to 0" do
      @wheel3.value.should == 0
    end
    
    it "and it can have a value outside the 0 to 9 range" do
      @wheel3.set_value(-3)
      @wheel3.value.should eql -3
    end

    it "only accepts numerical values" do
      expect{ @wheel3.set_value("a") }.to raise_error(ArgumentError, "Not a valid number a")
    end
  end

  it "it encodes a single character like MARK II" do
    markIV = setup_MARK_IV(1,2)
    markII = setup_MARK_II(1,2)
    markIV.encode('a').should == markII.encode('a')
  end
  
  context "it encodes the rest of the characters based on the first character's position" do
    it "it adds the previous character's position twice to the index" do
      markIV = setup_MARK_IV
      markIV.encode("2\"").should == '22'
    end

    it "for 1234 it should return 258B when the wheels are set to 1 and 2" do
      encoding_machine = setup_MARK_IV(1,0)
      encoding_machine.encode("1234").should == '258B'
    end
  end
  
  context "can find the answer to Part 3's question" do
    it "by encoding 'The white cliffs of Alghero are visible at night' when  the wheels are set to 4 and 7" do
      encoding_machine = setup_MARK_IV(4,7)
      encoding_machine.encode("The white cliffs of Alghero are visible at night").should == "JMl0kBp?20QixoivSc.2\"vvmls8KOk\"0jA,4kgt0OmUb,pm."
    end
  end
  
  context "PART IV: The machine can now decode" do
    it "decodes 22 to 2\\ when the wheels are set to 0 and 0" do
      encoding_machine = setup_MARK_IV(0,0)
      encoding_machine.decode("22").should == "2\""
    end

    it "it decodes 258b to 1234 for wheel positions 1,2" do
      encoding_machine = setup_MARK_IV(1,0)
      encoding_machine.decode("258B").should == "1234"
    end
    
    context "and can find the answer to the question" do
      it "by decoding 'WZyDsL3u'0TfxP06RtSSF 'DbzhdyFIAu2 zF f5KE\"SOQTNA8A\"NCKPOKG5D9GSQE'M86IGFMKE6'K4pEVPK!bv83I' at wheel positions 7,2 " do
        input = "WZyDsL3u'0TfxP06RtSSF 'DbzhdyFIAu2 zF f5KE\"SOQTNA8A\"NCKPOKG5D9GSQE'M86IGFMKE6'K4pEVPK!bv83I"
        encoding_machine = setup_MARK_IV(7,2)
        encoding_machine.decode(input).should == "The rockets will strike at coordinates 49.977984 7.9257857 422979.83 5536735.81 on Oct. 7th"
      end
    end
  end
end
