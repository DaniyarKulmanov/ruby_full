# frozen_string_literal: true

require_relative 'stations_interface'
require_relative 'routes_interface'
require_relative 'wagons_interface'
require_relative 'trains_interface'
require_relative 'menu_texts'

module RailwaysData
  include StationInterface
  include RoutesInterface
  include WagonsInterface
  include TrainsInterface

  private

  def seed
    generate_stations
    generate_routes
    generate_trains
    generate_wagons
    assign_wagons_to_trains
    generate_chiefs
  end

  def generate_stations
    STATION_NAMES.each { |name| stations << Station.new(name, CHIEF_NAMES.sample) }
  end

  def generate_routes
    routes << Route.new(stations[0], stations[1])
    routes[0].add_station(stations[-1])
  end

  def generate_trains
    TRAIN_NAMES.each do |number|
      trains << CargoTrain.new(number)
      trains << PassengerTrain.new(number)
    end
    trains[0].add_route(routes[0])
  end

  def generate_wagons
    7.times { cargo_wagons << CargoWagon.new(rand(100..500), 'cargo') }
    6.times { passenger_wagons << PassengerWagon.new(rand(300), 'passenger') }
  end

  def assign_wagons_to_trains
    trains.each do |train|
      cargo_wagons.each { |wagon| train.attach_wagon(wagon) if train.wagon_type == wagon.type }
      passenger_wagons.each { |wagon| train.attach_wagon(wagon) if train.wagon_type == wagon.type }
    end
  end

  def generate_chiefs
    rand(10).times do
      stations.each { |station| station.chief = CHIEF_NAMES.sample }
      trains.each { |train| train.chief = CHIEF_NAMES.sample }
    end
  end
end
