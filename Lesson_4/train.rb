class Train

  attr_reader :number, :type
  attr_accessor :speed, :wagons, :route, :station, :station_index

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def speed_up
    self.speed += 10
  end

  def stop
    self.speed = 0
  end

  def attach_wagon
    self.wagons += 1 if speed == 0
  end

  def unhitch_wagon
    self.wagons -= 1 if speed == 0 && self.wagons > 0
  end

  def add_route (route)
    self.route = route
    self.station = route.stations.first
    station.arrive(self)
    self.station_index = 0
  end

  def move_forward
    if route.stations.last != station
      self.station_index += 1
      travel
    else
      puts "Это последняя станция, можно двигаться только назад"
    end
  end

  def move_back
    if route.stations.first != station
      self.station_index -= 1
      travel
    else
      puts "Это первая станция, можно двигаться только вперед"
    end
  end

  def information
    station_read((station_index - 1), "предыдущая станция") if station_index > 0
    station_read(station_index, "текущая станция")
    station_read((station_index + 1), "следующая станция")
  end

  private

  def station_read(index, text)
    puts "#{text} = #{route.stations[index].name}"
  end

  def travel
    station.departure(self)
    self.station = route.stations[station_index]
    route.stations[station_index].arrive(self)
  end
end