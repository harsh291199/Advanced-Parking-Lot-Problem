# Parking lot class
class ParkingLot
  attr_reader :slots

  # Initialize the slots of the parking lot
  def initialize(size)
    @slots = Array.new(size)
  end

  # This shows the available slots in parking lot
  def available_slot
    slots.each_with_index do |slot, index|
      return index if slot.nil?
    end
    nil
  end

  # Park the car
  def park(car:, slot_num:)
    slots[slot_num] = car
  end

  # Park Process of car
  def park_process(reg_no:, color:, e_time:, l_time:, slot_num:)
    car = Car.new(reg_no: reg_no, color: color, e_time: e_time, l_time: l_time)
    park(car: car, slot_num: slot_num)
    puts 'Allocated slot number: ' + (slot_num + 1).to_s
    puts "Your Entry time is #{e_time}"
    puts "\n"
  end

  # Check if slot is free and if free then park the car
  def check_and_park(reg_no, color, e_time, l_time)
    slot_num = available_slot
    if slot_num
      park_process(reg_no: reg_no, color: color, e_time: e_time,
                   l_time: l_time, slot_num: slot_num)
    else
      puts 'Sorry, parking lot is full'
    end
  end

  def charge_for_parking(e_time, l_time, p_h_charge, g_period)
    entry_time = e_time.split(':').join('.').to_f
    leave_time = l_time.split(':').join('.').to_f
    gr_period = g_period.to_f / 100

    # time_in_pl = Car spend time in parking lot
    time_in_pl = leave_time - entry_time

    # if car's spend time in PL is less than Grace period then,
    # you have not to pay the charge
    if time_in_pl <= gr_period
      charge = 0
      charge
    # If car's spend time in PL is greater than Grace period then,
    # You have to pay according to hours
    elsif time_in_pl <= 1.00
      charge = 1 * p_h_charge.to_i
    else
      charge = time_in_pl * p_h_charge.to_i
    end
    charge
  end

  # Display the Entry and exit time of the car
  def print_log(slot_num, e_time, l_time)
    table_format = "Slot number | Entry time | Departure time\n"

    table_format += " #{slot_num} | #{e_time} | #{l_time}"
    table_format += "\n"
    puts table_format
    puts "\n"
  end

  # Leave the car
  def leave(slot_num)
    slots[slot_num] = nil
  end

  # Leave process of car
  def leave_process(reg_no, e_time, l_time, p_h_charge, g_period)
    slot_num = slot_num_by_registration_number(reg_no)
    if slot_num == 'Slot is not found'
      puts 'There is no car with this plate number in the parking lot' + "\n"
    else
      leave slot_num.to_i - 1
      # Here you get charge of the parking lot per hour
      charge_p_hour = charge_for_parking(e_time, l_time, p_h_charge, g_period)
      puts 'Slot number ' + slot_num.to_s + ' is free'
      puts "Paid #{charge_p_hour} Rs."
      puts "\n"
    end
    print_log(slot_num, e_time, l_time)
  end

  # Take color of the car and give register numbers of cars
  def get_reg_numbers_by_color(color)
    result = []
    slots.each do |slot|
      next unless slot
      result << slot.reg_no if slot.color == color
    end
    result
  end

  # Get plate number by color of car
  def plate_numbers_by_color(color)
    results = get_reg_numbers_by_color(color)
    results_in_str = results.join(', ')
    puts "Your car's plate number is #{results_in_str}"
    puts "\n"
  end

  # Take register number of the car and give slot number of car
  def get_slot_num_by_reg_no(reg_no)
    slots.each_with_index do |slot, idx|
      next unless slot
      return (idx + 1).to_s if slot.reg_no == reg_no
    end
    nil
  end

  # Get Slot number by plate number
  def slot_num_by_registration_number(reg_no)
    slot_num = get_slot_num_by_reg_no(reg_no)
    return 'Slot is not found' unless slot_num
    slot_num
  end

  # Take color of the car and give slot numbers of cars
  def get_slot_num_by_color(color)
    result = []
    slots.each_with_index do |slot, idx|
      next unless slot
      result << (idx + 1).to_s if slot.color == color
    end
    result
  end

  # Get Slot number by color of car
  def slot_numbers_by_color(color)
    results = get_slot_num_by_color(color)
    results_in_str = results.join(', ')
    puts "Your car's slot number in parking is #{results_in_str}"
    puts "\n"
  end
end
