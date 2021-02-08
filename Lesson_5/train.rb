class Train

  attr_reader :number,:speed, :station, :wagons
  attr_accessor :route, :station_index

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
  end

  def speed_up
    self.speed += 10
  end

  def stop
    self.speed = 0
  end

  def attach_wagon(wagon)
    self.wagons << wagon if speed == 0
  end

  def unhitch_wagon
    self.wagons.delete_at(-1) if speed == 0 && wagons.size > 0
  end

  def add_route (route)
    self.route = route
    self.station = route.stations.first
    station.arrive(self)
    self.station_index = 0
  end

  def move_forward
    if route.stations.last != station && route != nil
      self.station_index += 1
      travel
    else
      puts "Это последняя станция, можно двигаться только назад"
    end
  end

  def move_back
    if route.stations.first != station && route != nil
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
  # защите аттрибута от внешнего вмешательства
  attr_writer :speed, :station, :wagons
  # только для внутренних операций
  def station_read(index, text)
    puts "#{text} = #{route.stations[index].name}"
  end
  # только для внутренних операций
  def travel
    station.departure(self)
    self.station = route.stations[station_index]
    route.stations[station_index].arrive(self)
  end
end