# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'

class Station
  include InstanceCounter
  extend Accessors
  include Validation

  FORMAT = /(\A[А-Я])([а-я]|\d){3,80}$/.freeze

  attr_reader :name, :trains

  attr_accessor_with_history :chief
  strong_attr_accessor :town, String

  validate :name, :presence
  validate :name, :type, String
  validate :name, :format, FORMAT

  @stations = []

  class << self
    attr_accessor :stations
  end

  def self.all
    puts stations
  end

  def initialize(name, chief = '', town = '')
    @name = name
    self.town = town
    self.chief = chief
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

  def all_trains(&block)
    trains.each(&block) if block_given?
  end
end
