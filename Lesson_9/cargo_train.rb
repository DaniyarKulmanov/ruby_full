# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  def initialize(number, wagon_type = 'cargo')
    super
  end
end
