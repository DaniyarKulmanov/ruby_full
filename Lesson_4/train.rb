class Train

  attr_reader :number, :type
  attr_accessor :speed, :wagons, :route, :current_station

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
    self.wagons =+ 1 if speed == 0 && self.wagons > 0
  end

  def add_route (route)
    self.route = route
    self.current_station = route.stations.first
    self.current_station.arrive(self)
  end

  def move_forward
    # self.route.stations.find{|station| }
  end
end