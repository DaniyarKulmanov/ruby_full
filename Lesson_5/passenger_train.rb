require_relative 'train'

class PassengerTrain < Train

  def attach_wagon(wagon)
    if wagon.class == PassengerWagon
      super(wagon)
    else
      puts 'Можно прицепить только пассажирский вагон'
    end
  end
  
end