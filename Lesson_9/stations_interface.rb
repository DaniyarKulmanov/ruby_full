# frozen_string_literal: true

module StationInterface
  attr_reader :stations

  private

  attr_writer :stations

  def station_actions(command)
    station_create if command == 1
    if command == 2
      stations_list
      station_actions(paint_menu(STATION_MENU))
    end
    station_trains_display if command == 3
    main_menu if command.zero?
  end

  def station_create
    attempt ||= 3
    puts 'Введите имя станции'
    name = gets.chomp
    stations << Station.new(name)
    puts "Станция #{stations[-1].name} создана"
    station_actions(paint_menu(STATION_MENU))
  rescue RuntimeError => e
    attempt -= 1
    puts "#{e.message}, осталось попыток #{attempt}"
    retry if attempt.positive?
    station_actions(paint_menu(STATION_MENU))
  end

  def stations_list
    puts 'Список станций:'
    stations.each_with_index do |station, index|
      puts "#{index} - #{station.name} поезда:"
      station.trains.each_with_index { |train, train_index| puts " #{train_index} -> #{train.number}" }
    end
  end

  def station_trains_display
    puts 'Выберите станцию'
    station = choose_from('Stations', stations)
    puts "Список поездов на станции #{station.name}:"
    station.all_trains { |train| puts "Номер поезда - #{train.number}, вагонов #{train.wagons.size}" }
    station_actions(paint_menu(STATION_MENU))
  end
end
