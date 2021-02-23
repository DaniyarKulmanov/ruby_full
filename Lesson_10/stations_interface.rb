# frozen_string_literal: true

module StationInterface
  STATION = { 0 => :main_menu,
              1 => :station_processing,
              2 => :station_display,
              3 => :station_trains_display }.freeze

  attr_reader :stations

  private

  attr_writer :stations

  def station_actions(command)
    send STATION[command]
  rescue NoMethodError
    retry
  end

  def station_processing
    attempt ||= 3
    station_create
  rescue RuntimeError => e
    attempt -= 1
    puts "#{e.message}, осталось попыток #{attempt}"
    retry if attempt.positive?
    station_actions(paint_menu(STATION_MENU))
  end

  def stations_list
    puts 'Список станций:'
    stations.each_with_index do |station, index|
      station_details(station, index)
    end
  end

  def station_trains_display
    puts 'Выберите станцию'
    station = choose_from(:stations, stations)
    puts "Список поездов на станции #{station.name}:"
    station.all_trains { |train| puts "Номер поезда - #{train.number}, вагонов #{train.wagons.size}" }
    station_actions(paint_menu(STATION_MENU))
  end

  def station_create
    puts 'Введите имя станции'
    name = gets.chomp
    stations << Station.new(name)
    puts "Станция #{stations[-1].name} создана"
    station_actions(paint_menu(STATION_MENU))
  end

  def station_display
    stations_list
    station_actions(paint_menu(STATION_MENU))
  end

  def station_details(station, index)
    puts "№#{index} Станция #{station.name}, Шеф #{station.chief}, поезда:"
    station.trains.each_with_index { |train, train_index| puts " #{train_index} -> #{train.number}" }
    puts "Кто управлял станциями:"
    puts station.chief_history
  end
end
