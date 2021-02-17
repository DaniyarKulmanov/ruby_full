require_relative 'instance_counter'

class StationOld6
  include InstanceCounter

  attr_reader :name, :trains

  @@stations = []

  def self.all
    puts @@stations
  end

  def initialize (name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end

  def arrive (train)
    trains << train
  end

  def trains_by_type
    puts 'Грузовые поезда:'
    trains.select do |train|
      puts train.number if train.class == CargoTrain
    end
    puts 'Пассажирские поезда:'
    trains.select do |train|
      puts train.number if train.class == PassengerTrain
    end
  end

  def departure (train)
    trains.delete(train)
  end

  private

  # только для внутренних операций
  def train_info(type)
    # count = 0
    # trains.each do |train|
    #   count += 1 if train.type == type
    # end
    # count
  end
end