# frozen_string_literal: true

module WagonsInterface
  WAGON = { 0 => :main_menu,
            1 => :wagon_processing,
            2 => :wagon_display,
            3 => :cargo_wagon_reserve_capacity,
            4 => :passenger_wagon_reserve_seats }.freeze

  attr_reader :wagons

  private

  attr_writer :wagons

  def wagon_actions(command)
    send WAGON[command]
  rescue NoMethodError
    retry
  end

  def wagon_processing
    attempt ||= 3
    wagon_create
  rescue RuntimeError => e
    attempt -= 1
    puts "#{e.message}, осталось попыток #{attempt}"
    retry if attempt.positive?
    wagon_actions(paint_menu(WAGON_MENU))
  end

  def wagon_display
    wagon_list
    wagon_actions(paint_menu(WAGON_MENU))
  end

  def cargo_wagon_create
    puts 'Укажите объем'
    value = gets.chomp.to_i
    wagons << CargoWagon.new(value)
    puts "Вагон #{wagons[-1].type} создан, объем = #{wagons[-1].capacity}"
  end

  def cargo_wagon_reserve_capacity
    puts 'Выберите вагон типа cargo!'
    wagon = choose_from('Wagons', wagons)
    if wagon.type == 'cargo'
      puts 'Сколько объема занять, укажите числовое значение!'
      capacity = gets.chomp.to_i
      wagon.take_capacity(capacity)
      puts "Осталось объема #{wagon.free_capacity}"
    else
      puts "Вы выбрали не верный тип вагона = #{wagon.type}"
    end
    wagon_actions(paint_menu(WAGON_MENU))
  rescue RuntimeError => e
    puts e.message
    wagon_actions(paint_menu(WAGON_MENU))
  end

  def passenger_wagon_create
    puts 'Укажите количество мест'
    value = gets.chomp.to_i
    wagons << PassengerWagon.new(value)
    puts "Вагон #{wagons[-1].type} создан, мест = #{wagons[-1].seats}"
  end

  def passenger_wagon_reserve_seats
    puts 'Выберите вагон типа passenger!'
    wagon = choose_from('Wagons', wagons)
    if wagon.type == 'passenger'
      puts 'Сколько мест занять, укажите числовое значение!'
      seats = gets.chomp.to_i
      wagon.take_seat(seats)
      puts "Осталось мест #{wagon.free_seats}"
    else
      puts "Вы выбрали не верный тип вагона = #{wagon.type}"
    end
    wagon_actions(paint_menu(WAGON_MENU))
  rescue RuntimeError => e
    puts e.message
    wagon_actions(paint_menu(WAGON_MENU))
  end

  def wagon_list
    puts 'Список вагонов'
    wagons.each_with_index do |wagon, index|
      if wagon.instance_of?(CargoWagon)
        puts "#{index} - Вагон типа #{wagon.type}, свободный объем: #{wagon.free_capacity}"
      else
        puts "#{index} - Вагон типа #{wagon.type} свободных мест: #{wagon.free_seats}"
      end
    end
  end

  def wagon_create
    puts 'Какой вагон создать'
    puts TRAIN_WAGON_TYPE
    type = gets.chomp.to_i
    cargo_wagon_create if type == 1
    passenger_wagon_create if type == 2
    wagon_actions(paint_menu(WAGON_MENU))
  end
end
