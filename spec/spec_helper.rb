require 'MarkI'
require 'MarkII'
require 'MarkIV'
require 'Validator'
require 'Wheel'
require 'rspec'

def setup_MARK_II(wheel1_position=0, wheel2_position=0)
  machine = Minisculus::MarkII.new
  machine.wheel(1).set_value(wheel1_position)
  machine.wheel(2).set_value(wheel2_position)
  machine
end

def setup_MARK_IV(wheel1_position=0, wheel2_position=0)
   machine = Minisculus::MarkIV.new
   machine.wheel(1).set_value(wheel1_position)
   machine.wheel(2).set_value(wheel2_position)
   machine
end
