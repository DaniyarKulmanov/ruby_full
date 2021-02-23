# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'accessors'

class Station
  include InstanceCounter
  extend Accessors

  FORMAT = /(\A[А-Я])([а-я]|\d){3,80}$/.freeze

  attr_reader :name, :trains
  attr_accessor_with_history :chief

  @stations = []

  class << self
    attr_accessor :stations
  end

  def self.all
    puts stations
  end

  def initialize(name, chief)
    @name = name
    @chief = chief
    validate!
    @trains = []
    self.class.stations << self
    register_instance
  end

  def arrive(train)
    trains << train
  end

  def trains_by_type
    puts 'Грузовые поезда:'
    trains.select do |train|
      puts train.number if train.instance_of?(CargoTrain)
    end
    puts 'Пассажирские поезда:'
    trains.select do |train|
      puts train.number if train.instance_of?(PassengerTrain)
    end
  end

  def departure(train)
    trains.delete(train)
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def all_trains(&block)
    trains.each(&block) if block_given?
  end

  private

  def validate!
    raise 'Не верный формат: только кириллица, цифры, длинна от 3 - 80 символов' if name !~ FORMAT
  end
end
