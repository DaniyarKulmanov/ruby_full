require_relative 'train'

class CargoTrain < Train
  def initialize(number, wagon_type = 'Cargo')
    super
  end
end