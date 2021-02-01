class Station
  attr_reader :name, :trains

  def initialize (name)
    @name = name
    @trains = []
  end

  def arrive (train)
    trains << train
  end

  def trains_by_type
  end

  def departure (train)
    trains.delete(train)
  end
end