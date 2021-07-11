# Car class
class Car
  attr_reader :reg_no, :color

  # Intialize the register number and color of the car
  def initialize(reg_no:, color:, e_time:, l_time:)
    @reg_no = reg_no
    @color = color
    @e_time = e_time
    @l_time = l_time
  end
end
