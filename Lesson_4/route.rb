class Route
  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]
  end

  def add_station (station)
    self.stations.insert(-2, station)
  end

  def remove_station (station)
    if not_first_and_last(station)
      self.stations.delete station
    else
      puts "Начальную и конечную станцию удалить нельзя"
    end
  end

  def print_stations
    puts "Станции маршрута:"
    self.stations.each_with_index{|value,index| puts "#{index + 1} = #{value}" }
  end

  private

  def not_first_and_last(station)
    station != self.stations.first && station != self.stations.last
  end

end