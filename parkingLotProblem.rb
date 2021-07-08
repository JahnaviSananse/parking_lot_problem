$create_parking_lot
$total_slots
$id = 0

def create_parking_slot
  $create_parking_lot = []
  print 'create_parking_lot : '
  $total_slots = gets.chomp.to_i
  # print $total_slots
  i = 0
  while i < $total_slots
    parking_hash = {}
    print 'Park '
    plate_num = gets.chomp
    colour = gets.chomp
    parking_hash['id'] = $id += 1
    parking_hash['plate_num'] = plate_num
    parking_hash['colour'] = colour
    parking_hash['alloted'] = true
    i += 1
    $create_parking_lot << parking_hash
    puts "Allocated slot number : #{i}"
  end
  puts $create_parking_lot
end

def show_status
  puts 'enter choice : '
  choice = gets.chomp
  index = 0
  if choice == 'status'
    puts 'Number | plate_num   | Colour'
    $create_parking_lot.map do |hash|
      next if hash['alloted'] == false
      puts "#{index += 1}| #{hash['plate_num']} | #{hash['colour']}"
    end
  end
end

def remove_slot
  puts 'Which slot you want to leave ? '
  remove_id = gets.chomp.to_i
  if $create_parking_lot.length < remove_id
    puts 'Invalid slot entry'
    return 0
  end
  $create_parking_lot[remove_id - 1]['alloted'] = false
  puts $create_parking_lot
  puts 'Number | plate_num   | Colour'
  $create_parking_lot.map do |hash|
    next if hash['alloted'] == false
    puts "#{hash['id']}  | #{hash['plate_num']} | #{hash['colour']}"
  end
end

def search_car_data
  puts 'Enter color : '
  car_color = gets.chomp
  $create_parking_lot.map do |hash|
    next unless hash['colour'] == car_color
    if hash['alloted'] == false
      puts 'This is not available'
      next
    end
    puts "#{hash['id']}  | #{hash['plate_num']} | #{hash['colour']}"
  end
end

def search_car_slot
  puts "Enter car's number : "
  car_num = gets.chomp
  $create_parking_lot.map do |hash|
    puts "#{hash['id']}.to_S" if hash['plate_num'] == car_num
  end
end

def park_car_in_slot
  puts 'park '
  plate_num = gets.chomp
  colour = gets.chomp
  check_flag = 1
  $create_parking_lot.map do |hash|
    next unless hash['alloted'] == false
    check_flag = 2
    hash['plate_num'] = plate_num
    hash['colour'] = colour
    puts "#{hash['plate_num']} | #{hash['colour']}"
    puts "#{hash['id']}  | #{hash['plate_num']} | #{hash['colour']}"
    break
  end
  puts 'Sorry! Parking is full' if check_flag == 1
end

def pass_in_entry_time
  $create_parking_lot = []
  print 'create_parking_lot : '
  $total_slots = gets.chomp.to_i
  # print $total_slots
  i = 0
  while i < $total_slots
    parking_hash = {}
    print 'Park '
    plate_num = gets.chomp
    colour = gets.chomp
    time = Time.now
    show_time = time.hour.to_s + ' : ' + time.min.to_s
    puts "entry-time =>  #{show_time} "
    parking_hash['id'] = $id += 1
    parking_hash['plate_num'] = plate_num
    parking_hash['colour'] = colour
    parking_hash['time'] = show_time
    parking_hash['hour_in'] = time.hour.to_i
    parking_hash['min_in'] = time.min.to_i
    parking_hash['sec_in'] = time.sec.to_i
    # puts ">>>>>>>>>>>>>>>>>>>> #{parking_hash['hour_in']}"
    # parking_hash['time_out']
    parking_hash['alloted'] = true
    i += 1
    $create_parking_lot << parking_hash
    puts "Allocated slot number : #{i}"
  end
  puts $create_parking_lot
end

def exit_time
  puts 'Which slot you want to leave ? '
  remove_id = gets.chomp.to_i
  if $create_parking_lot.length < remove_id
    puts 'Invalid slot entry'
    return 0
  end
  $create_parking_lot[remove_id - 1]['alloted'] = false
  puts $create_parking_lot
  entry_time_false_hr = $create_parking_lot[remove_id - 1]['hour_in']
  # puts "########### #{entry_time_false_hr}"
  entry_time_false_min = $create_parking_lot[remove_id - 1]['min_in']
  # puts "~~~~~~~~~~ #{entry_time_false_min}"
  entry_time_false_sec = $create_parking_lot[remove_id - 1]['sec_in']
  # puts "@@@@@@@@@@ #{entry_time_false_sec}"
  exit_timee = Time.now
  minus_sec = exit_timee.sec.to_i - entry_time_false_sec
  puts "%%%%% #{minus_sec}"
  if minus_sec <= 5
    puts 'No need to pay'
  else
    rupee = minus_sec * 1
    puts "You have to pay #{rupee}"
  end

  show_exit_time = exit_timee.hour.to_s + ' : ' + exit_timee.min.to_s
  puts 'Number | plate_num   | Colour  | Time-In | Time-Out'
  $create_parking_lot.map do |hash|
    if hash['alloted'] == false
      hash['exit_timee'] = show_exit_time
      puts "slot #{hash['id']} is free"
      next
    end
    puts "#{hash['id']}  | #{hash['plate_num']} | #{hash['colour']} | #{hash['time']} | #{show_exit_time}"
  end
end

def status_in_out_time
  exit_timee = Time.now
  show_exit_time = exit_timee.hour.to_s + ' : ' + exit_timee.min.to_s
  index = 0
  puts 'Number | plate_num   | Colour | In-Time | Out-Time'
  $create_parking_lot.map do |hash|
      puts "#{index += 1}| #{hash['plate_num']} | #{hash['colour']} | #{hash['time']} |  #{hash['exit_timee']} "
  end
end

while true
  puts 'Which operation do you want to perform ? '
  puts '1. Add Data : '
  puts '2. Remove Data  : '
  puts '3. Data Status : '
  puts "4. Search Car's by color : "
  puts "5. Search Car's slot by number : "
  puts '6. Park car in allocated slot : '
  puts '7. Pass in a entry time on park call : '
  puts '8. Exit time on leave call : '
  puts '9. Status with In-Out time : '
  puts '10. Exit : '
  operation = gets.chomp.to_i
  case operation
  when 1
    create_parking_slot
  when 2
    remove_slot
  when 3
    show_status
  when 4
    search_car_data
  when 5
    search_car_slot
  when 6
    park_car_in_slot
  when 7
    pass_in_entry_time
  when 8
    exit_time
  when 9
    status_in_out_time
  when 10
    break
  else
    puts 'Enter valid operation'
  end
end
