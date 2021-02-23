# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'manufacturer'

class Wagon
  include InstanceCounter
  include Manufacturer

  MADE_IN = /^(standard|cargo|passenger)/i.freeze

  attr_reader :open_locks, :type

  def initialize(type = 'standard')
    @type = type
    validate!
    close_doors
    register_instance
  end

  def open_doors
    self.open_locks = true
  end

  def close_doors
    self.open_locks = false
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  attr_writer :open_locks

  def validate!
    raise 'Тип поезда только standard, passenger, cargo' if type !~ MADE_IN
  end
end
