require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  include Manufacturer
  include InstanceCounter

  FORMAT = /^([а-я]|\d){3}[-]*([а-я]|\d){2}$/i

  attr_reader :speed, :station, :wagons, :wagon_type
  attr_accessor :number, :route, :station_index

  @@trains = []

  def self.find(number)
    @@trains.find {|train| train.number == number}
  end

  def initialize(number, wagon_type = 'standard')
    @number = number
    validate!
    @wagons = []
    @speed = 0
    @wagon_type = wagon_type
    @@trains << self
    register_instance
  end

  def speed_up
    self.speed += 10
  end

  def stop
    self.speed = 0
  end

  def attach_wagon(wagon)
    if speed == 0 && wagon_type == wagon.type
      self.wagons << wagon
    else
      puts "Остановите поезд и прицепить можно только вагоны = #{wagon_type}"
    end
  end

  def unhitch_wagon
    if speed == 0 && wagons.size > 0
      self.wagons.delete_at(-1)
    elsif wagons.size <= 0
      puts 'Нет Вагонов для отцепления'
    end
  end

  def add_route (route)
    self.route = route
    self.station = route.stations.first
    station.arrive(self)
    self.station_index = 0
  end

  def move_forward
    if route != nil && route.stations.last != station
      self.station_index += 1
      travel
    elsif route.nil?
      puts "Сначала назначьте маршут поезду"
    else
      puts "Это последняя станция, можно двигаться только назад"
    end
  end

  def move_back
    if route != nil && route.stations.first != station
      self.station_index -= 1
      travel
    elsif route.nil?
      puts "Сначала назначьте маршут поезду"
    else
      puts "Это первая станция, можно двигаться только вперед"
    end
  end

  def information
    station_read((station_index - 1), "предыдущая станция") if station_index > 0
    station_read(station_index, "текущая станция")
    station_read((station_index + 1), "следующая станция")
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def all_wagons
    wagons.each_with_index do |wagon, index|
      if block_given?
        yield(wagon, index)
      else
        puts "No block given"
        break
      end
    end
  end

  private

  attr_writer :speed, :station, :wagons

  def station_read(index, text)
    puts "#{text} = #{route.stations[index].name}"
  end

  def travel
    station.departure(self)
    self.station = route.stations[station_index]
    route.stations[station_index].arrive(self)
  end

  def validate!
    raise 'Не верный формат позда ХХХ-ХХ' if number !~ FORMAT
  end
end