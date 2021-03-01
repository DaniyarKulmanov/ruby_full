# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'validation'

class Wagon
  include InstanceCounter
  include Manufacturer
  include Validation

  MADE_IN = /^(standard|cargo|passenger)/i.freeze

  attr_reader :open_locks, :model

  validate :type, :format, MADE_IN

  def initialize(model = 'standard')
    @model = model
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

  private

  attr_writer :open_locks
end
