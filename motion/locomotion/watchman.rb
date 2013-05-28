module Locomotion
  class Watchman

    def init location_manager = CLLocationManager
      @location_manager = location_manager.alloc.init
      @location_manager.delegate        = Locomotion::Delegate.alloc.initWith(self)
      @location_manager.distanceFilter  = KCLDistanceFilterNone
      @location_manager.desiredAccuracy = KCLLocationAccuracyBest
      self
    end
    attr_reader :location_manager

    def process options = {}
      @location_manager.purpose = options[:purpose] if options[:purpose]
    end

    def listeners
      @listeners ||= []
    end

    def go
      @location_manager.startUpdatingLocation
    end

    def pause time
      @location_manager.allowDeferredLocationUpdatesUntilTraveled 10000, timeout: time
    end

    def clear
      @location_manager.stopUpdatingLocation
    end

    def update location
      @listeners.each do |listener|
        listener.call Location.alloc.init(location)
      end
    end

    def error code
    end

  end
end
