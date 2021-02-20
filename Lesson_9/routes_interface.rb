# frozen_string_literal: true

module RoutesInterface
  ROUTE = { 0 => :main_menu,
            1 => :route_create,
            2 => :route_display,
            3 => :routes_add_station,
            4 => :routes_del_station }.freeze

  attr_reader :routes

  private

  attr_writer :routes

  def route_actions(command)
    send ROUTE[command]
  rescue NoMethodError
    retry
  end

  def route_display
    routes_list
    route_actions(paint_menu(ROUTE_MENU))
  end

  def route_create
    puts 'Выберите начальную станцию'
    first_station = choose_from(:stations, stations)
    puts 'Выберите конечную станцию'
    last_station = choose_from(:stations, stations)
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
    route = choose_from(:routes, routes)
    puts 'Какую станцию добавить'
    station = choose_from(:stations, stations)
    route.add_station(station)
    route_actions(paint_menu(ROUTE_MENU))
  end

  def routes_del_station
    puts 'Выберите маршрут где хотите удалить станцию:'
    route = choose_from(:routes, routes)
    puts 'Какую станцию удалить'
    station = choose_from(:stations, stations)
    route.remove_station(station)
    route_actions(paint_menu(ROUTE_MENU))
  end
end
