# frozen_string_literal: true

module RoutesInterface
  attr_reader :routes

  private

  attr_writer :routes

  def route_actions(command)
    route_create if command == 1
    if command == 2
      routes_list
      route_actions(paint_menu(ROUTE_MENU))
    end
    routes_add_station if command == 3
    routes_del_station if command == 4
    main_menu if command.zero?
  end

  def route_create
    puts 'Выберите начальную станцию'
    first_station = choose_from('Stations', stations)
    puts 'Выберите конечную станцию'
    last_station = choose_from('Stations', stations)
    routes << Route.new(first_station, last_station)
    route_actions(paint_menu(ROUTE_MENU))
  end

  def routes_list
    puts 'Выбрать маршрут:'
    routes.each_with_index do |route, index|
      puts "#{index} - Маршрут #{route.first_station.name} - #{route.last_station.name}:"
      route.print_stations
    end
  end

  def routes_add_station
    puts 'Выберите маршрут куда хотите добавить станцию:'
    route = choose_from('Routes', routes)
    puts 'Какую станцию добавить'
    station = choose_from('Stations', stations)
    route.add_station(station)
    route_actions(paint_menu(ROUTE_MENU))
  end

  def routes_del_station
    puts 'Выберите маршрут где хотите удалить станцию:'
    route = choose_from('Routes', routes)
    puts 'Какую станцию удалить'
    station = choose_from('Stations', stations)
    route.remove_station(station)
    route_actions(paint_menu(ROUTE_MENU))
  end
end
