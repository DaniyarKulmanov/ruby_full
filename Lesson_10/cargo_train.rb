# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  @trains = []
  validate :number, :format, FORMAT

  def initialize(number, wagon_type = 'cargo')
    super
  end
end
