require_relative 'parking_lot'
require_relative 'car'

# Parking System class
class ParkingSystem
  attr_reader :parking_lot

  # Create a parking lot of input size
  def create_parking_lot(size_in_str, charge, g_period)
    size_in_int = size_in_str.to_i
    @parking_lot = ParkingLot.new(size_in_int)
    @size_in_str = size_in_str
    @charge = charge
    @g_period = g_period

    puts 'Created a parking lot with ' + size_in_str + ' slots.'
    puts 'Charge is ' + charge + ' Rs. per hour.'
    puts 'Grace period is ' + g_period + ' minutes.'
    puts "\n"
  end

  # Input for create PL
  def create_pl_input
    puts 'Enter the number of slots:'
    slot_no = STDIN.gets.chomp

    puts 'Enter the Charge for the one hour:'
    charge = STDIN.gets.chomp

    puts 'Enter the Grace period time:'
    g_period = STDIN.gets.chomp
    create_parking_lot(slot_no, charge, g_period)
  end

  # Input for Park the car
  def park_car_input
    puts 'Enter plate number of your car:'
    @plate_no = STDIN.gets.chomp

    puts 'Enter Colour of your car:'
    @color = STDIN.gets.chomp

    puts 'Enter the entry time:'
    @entry_time = STDIN.gets.chomp

    parking_lot.check_and_park(@plate_no, @color, @entry_time, @exit_time)
  end

  # Input for leave the car
  def leave_car_input
    puts 'Enter plate number of your car:'
    plate_no = STDIN.gets.chomp

    puts 'Enter the exit time:'
    @exit_time = STDIN.gets.chomp
    parking_lot.leave_process(plate_no, @entry_time,
                              @exit_time, @charge, @g_period)
  end

  # Print the Status of car including hourly rate and grace period
  def print_status(slots)
    table_format = "Numbers of Slots |  Hourly Rate  |  Grace Period\n"
    table_format += @size_in_str + ' Slots  |  ' + @charge + ' Rs.  |  ' +
                    @g_period + ' minuts'
    table_format += "\n"
    puts table_format
    puts "\n"

    status = "Slot No. | Plate No. | Colour\n"

    slots.each_with_index do |slot, id|
      next unless slot
      status += (id + 1).to_s + ' | ' + slot.reg_no + ' | ' + slot.color
      status += "\n"
    end
    puts status
    puts "\n"
  end

  # Input as color to search plate number of car
  def color_input_for_plate
    puts 'Enter the colour of car:'
    color = STDIN.gets.chomp
    parking_lot.plate_numbers_by_color(color)
  end

  # Input as color to search plate number of car
  def color_input_for_slot
    puts 'Enter the colour of car:'
    color = STDIN.gets.chomp
    parking_lot.slot_numbers_by_color(color)
  end

  # Input as color to search plate number of car
  def regno_input_for_slot
    puts 'Enter the plate number of car:'
    reg_no = STDIN.gets.chomp

    slot_no = parking_lot.slot_num_by_registration_number(reg_no)
    puts "Your car's slot number in parking is #{slot_no}"
    puts "\n"
  end

  def parse_input(input)
    input = input.to_i
    case input
    when 1
      create_pl_input
    when 2
      park_car_input
    when 3
      leave_car_input
    when 4
      print_status parking_lot.slots
    when 5
      color_input_for_plate
    when 6
      color_input_for_slot
    when 7
      regno_input_for_slot
    else
      puts 'Enter valid input!!'
      exit(0)
    end
  end

  # Get User Input
  def run
    loop do
      puts '1. Create a Parking Lot'
      puts '2. Park your car in Parking Lot'
      puts '3. Leave from Parking Lot'
      puts '4. Status of Parking Lot'
      puts "5. Search your car plate number with it's colour"
      puts "6. Search your car slot number with it's colour"
      puts "7. Search your car slot number with it's plate number:"
      puts 'Enter your Input >>>'
      parse_input STDIN.gets.strip
    end
  end
end

object = ParkingSystem.new
object.run
