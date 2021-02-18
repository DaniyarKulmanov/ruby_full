class StationOld5
  attr_reader :name, :trains

  def initialize (name)
    @name = name
    @trains = []
  end

  def arrive (train)
    trains << train
  end

  def departure (train)
    trains.delete(train)
  end

  private

  # только для внутренних операций
  def train_info(type)
    # count = 0
    # trains.each do |train|
    #   count += 1 if train.type == type
    # end
    # count
  end
end