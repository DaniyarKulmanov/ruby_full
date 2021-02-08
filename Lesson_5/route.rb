class Route
  attr_reader :stations, :first_station, :last_station

  def initialize(first, last)
    @first_station = first
    @last_station = last
    @stations = []
    @stations << first_station
    @stations << last_station
  end

  def add_station (station)
    if stations.include? station
      puts "Станция уже есть в маршруте"
    else
      stations.insert(-2, station)
    end
  end

  def remove_station (station)
    if not_first_and_last(station)
      stations.delete station
    else
      puts "Начальную и конечную станцию удалить нельзя"
    end
  end

  def print_stations
    puts "Станции маршрута:"
    stations.each { |station| puts "-> #{station.name}" }
  end

  private
  # только для внутренних операций
  def not_first_and_last(station)
    station != stations.first && station != stations.last
  end

end