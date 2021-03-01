# frozen_string_literal: true

require_relative 'wagon'

class PassengerWagon < Wagon
  attr_reader :seats, :occupied_seats, :free_seats

  validate :seats, :type, Integer
  validate :seats, :zero
  validate :negative_seats, :negative

  def initialize(seats, model = 'passenger')
    @seats = seats
    @free_seats = seats
    @negative_seats = seats
    @occupied_seats = 0
    super(model)
  end

  def take_seat(value)
    self.negative_seats = free_seats - value
    validate!
    self.free_seats -= value
    self.occupied_seats += value
  end

  private

  attr_writer :seats, :occupied_seats, :free_seats
  attr_accessor :negative_seats
end
