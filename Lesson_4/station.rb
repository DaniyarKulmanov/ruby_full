class Station
  attr_reader :name, :trains

  def initialize (name)
    @name = name
    @trains = []
  end

  def arrive (train)
    self.trains << train
  end

  def trains_by_type
    puts "Количество поздов по типу:"
    puts "Грузовые #{train_info('Cargo')}"
    puts "Пассажирские #{train_info('Passenger')}"
  end

  def departure (train)
    self.trains.delete(train)
  end

  def train_info(type)
    count = 0
    self.trains.each do |train|
      count += 1 if train.type == type
    end
    count
  end
end