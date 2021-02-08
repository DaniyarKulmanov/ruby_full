require_relative 'wagon'

class CargoWagon < Wagon
  def attach_wagon(wagon)
    if wagon.class == CargoWagon
      super
    else
      puts "Можно прицепить только грузовой вагон"
    end
  end
end