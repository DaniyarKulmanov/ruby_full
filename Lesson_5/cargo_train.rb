require_relative 'train_old'

class CargoTrain < TrainOld
  def initialize(number, wagon_type = 'Cargo')
    super
  end
end