require_relative 'instance_counter'

class Station
  include InstanceCounter

  FORMAT = /(\A[А-Я])([а-я]|\d){3,80}$/

  attr_reader :name, :trains

  @@stations = []

  def self.all
    puts @@stations
  end

  def initialize (name)
    @name = name
    validate!
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

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    raise 'Не верный формат: только кириллица, цифры, длинна от 3 - 80 символов' if name !~ FORMAT
  end
end