class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains=[]
  end

  def arrival(train)
    @trains<<train
  end

  def trains_on_station
    @trains.map { |key, value| return key, value }
  end

  def trains_by_type(type)
    @trains.map{ |key, value| puts key.number, key.type if key.type == type }
  end

  def train_depart(train)
    @trains.delete(train)
    train.station=nil
  end
end

class Train
  attr_accessor :speed, :station, :route
  attr_reader :wagon, :type, :number

  def initialize(number, type, wagon=0)
    @number = number
    @type = type
    @wagon = wagon
    @speed = 0
  end

  def stop
    @speed=0
  end

  def wagon_add
    if @speed == 0
      @wagon+=1
    else
      puts "Поезд должен стоять"
    end
  end

  def wagon_remove
    if @wagon == 0
      puts "Нечего отцеплять"
    elsif speed == 0
      @wagon -= 1
    else
      puts "Поезд должен стоять"
    end
  end

  def add_route(route)
    self.route=route
  end
  def next_station(station)
    if route.nil?
      puts "Нет маршрута"
    elsif route.stations.include?(station)
      @station.train_depart(self) if @station
      @station = station
      station.arrival(self)
    end
  end

  def next_previous
    if route.nil?
      puts "Нет маршрута"
    else
      station_index = route.stations.index(station)
      puts "Текущая станция: #{station.name}."
      puts "Предыдущая - #{route.stations[station_index - 1].name}." if station_index != 0
      puts "Следующая - #{route.stations[station_index + 1].name}." if station_index != route.stations.size - 1
    end
  end
end

class Route
  attr_accessor :stations, :depart, :arrive

  def initialize(depart, arrive)
    @stations = [depart, arrive]
  end

  def add_station(station)
    self.stations.insert(rand(1..self.stations.size-1), station)
  end

  def delete_station(station)
    if [stations.first, stations.last].include?(station)
      puts "Невозможно удалить первую и последнюю станцию маршрута"
    else
      self.stations.delete(station)
    end
  end

  def show_stations
    puts stations.map{|el| el.name}
  end
end
