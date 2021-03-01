# frozen_string_literal: true

require_relative 'wagon'

class CargoWagon < Wagon
  attr_reader :capacity, :occupied_capacity, :free_capacity

  validate :capacity, :type, Integer
  validate :capacity, :zero
  validate :negative_capacity, :negative

  def initialize(capacity, model = 'cargo')
    @capacity = capacity
    @free_capacity = capacity
    @negative_capacity = capacity
    @occupied_capacity = 0
    super(model)
  end

  def take_capacity(value)
    self.negative_capacity = free_capacity - value
    validate!
    self.free_capacity -= value
    self.occupied_capacity += value
  end

  private

  attr_writer :capacity, :occupied_capacity, :free_capacity
  attr_accessor :negative_capacity
end
