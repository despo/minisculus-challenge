require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
describe 'Minisculus::Part I::MarkI Encoding Machine' do
  def setup_MARK_I(wheel_position=0)
    encoding_machine = Minisculus::MarkI.new
    encoding_machine.wheel.set_value wheel_position
    return encoding_machine
  end
  
  it 'is a MarkI' do
    encoding_machine = setup_MARK_I
    encoding_machine.should be_a Minisculus::MarkI
  end
  
  describe "wheel" do
    it "can have a value of 2" do
      encoding_machine = Minisculus::MarkI.new
      encoding_machine.wheel.set_value(2)
      encoding_machine.wheel.value.should eql 2
    end

    it "and a value up to 9" do
      markI = setup_MARK_I(9)
      markI.wheel.value.should eql 9
    end

    it "but no less than 0" do
      encoding_machine = Minisculus::MarkI.new
      expect{ encoding_machine.wheel.set_value(-2)}.to raise_error(ArgumentError, "Number not in valid range")
    end

    it "and no more than 9" do
      encoding_machine = Minisculus::MarkI.new
      expect{ encoding_machine.wheel.set_value(11)}.to raise_error(ArgumentError, "Number not in valid range")
    end
  end

  it "has a keyboard set" do
    Minisculus::MarkI::KEYBOARD.should_not be_nil
  end

  it "expects an input" do
    encoding_machine = setup_MARK_I
    expect{ encoding_machine.encode}.to raise_error ArgumentError
  end

  describe "encoding" do
    it "for encoder wheel set to 5 and input 'a' it should return 'f'" do
      encoding_machine = setup_MARK_I(5)
      encoding_machine.encode("a").should eql 'f'
    end

    it "for encoder wheel set to 5 and input 'c' it should return 'h'" do
      encoding_machine = setup_MARK_I(5)
      encoding_machine.encode("c").should eql 'h'
    end

    it "for encoder wheel set to 5 and input 'abc' it should return 'fgh'" do
      encoding_machine = setup_MARK_I(5)
      encoding_machine.encode("abc").should eql 'fgh'
    end

    it "for encoder wheel set to 1 and input '11' it should return '22'" do
      encoding_machine = setup_MARK_I(1)
      encoding_machine.encode("11").should eql '22'
    end
  end

  context "can find the solution to the problem" do
    it "'Strong NE Winds!' should encode to Yzxotm5TK5cotjy2" do
      encoding_machine = setup_MARK_I(6)
      encoding_machine.encode("String NE Winds!").should eql "Yzxotm5TK5cotjy2"
    end
  end
end
