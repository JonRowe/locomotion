class FakeLocationManager
  attr_accessor :delegate, :distanceFilter, :desiredAccuracy, :purpose

  def distanceFilter= value
    commands << [:distanceFilter,value]
    @distanceFilter = value
  end

  def desiredAccuracy= value
    commands << [:desiredAccuracy,value]
    @desiredAccuracy= value
  end

  def startUpdatingLocation
    commands << :start
  end

  def stopUpdatingLocation
    commands << :stop
  end

  def allowDeferredLocationUpdatesUntilTraveled distance, timeout: time
    commands << [:defer,distance,time]
  end

  def commands
    @commands ||= []
  end

  def reset
    @commands = []
  end
end
