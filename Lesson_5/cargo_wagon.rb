require_relative 'wagon_old'

class CargoWagon < WagonOld
  def initialize(manufacturer, type = 'Cargo')
    super
  end
end