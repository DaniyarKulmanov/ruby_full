require_relative 'train_old'

class PassengerTrain < TrainOld
  def initialize(number, wagon_type = 'Passenger')
    super
  end
end