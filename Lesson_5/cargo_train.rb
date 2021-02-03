require_relative 'train'

class CargoTrain < Train

  def attach_wagon(wagon)
    if wagon.class == CargoWagon
      super(wagon)
    else
      puts 'Только грузовые вагоны'
    end
  end
end