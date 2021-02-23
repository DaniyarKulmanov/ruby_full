# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  @trains = []

  def initialize(number, wagon_type = 'cargo')
    super
  end
end
