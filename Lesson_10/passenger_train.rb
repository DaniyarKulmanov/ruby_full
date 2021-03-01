# frozen_string_literal: true

require_relative 'train'

class PassengerTrain < Train
  @trains = []
  validate :number, :format, FORMAT

  def initialize(number, wagon_type = 'passenger')
    super
  end
end
