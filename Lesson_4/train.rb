class Train

  attr_reader :number, :type
  attr_accessor :speed, :wagons, :route, :station

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
    self.route.stations.first.arrive(self)
    self.station = 0
  end

  def move_forward
    move(1)
  end

  def move_back
    move(-1)
  end

  def information
    station_read((self.station - 1), "предыдущая станция") if self.station > 0
    station_read(self.station, "текущая станция")
    station_read((self.station + 1), "следующая станция")
  end

  private

  def move(direction)
    self.route.stations[station].departure(self)
    self.route.stations[station + direction].arrive(self)
    self.station += direction
  end

  def station_read(index, text)
    puts "#{text} = #{self.route.stations[index].name}"
  end
end