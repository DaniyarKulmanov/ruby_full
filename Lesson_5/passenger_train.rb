require_relative 'train'

class PassengerTrain < Train

  def attach_wagon(wagon)
    if wagon.class == PassengerWagon
      super(wagon)
    else
      puts 'Только пассажирские вагоны'
    end
  end
  
end