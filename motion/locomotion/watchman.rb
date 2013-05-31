module Locomotion
  class Watchman

    def init location_manager = CLLocationManager
      @delegate         = Locomotion::Delegate.alloc.initWith(self)
      @location_manager = location_manager.alloc.init
      @location_manager.delegate        = @delegate
      @location_manager.distanceFilter  = KCLDistanceFilterNone
      @location_manager.desiredAccuracy = KCLLocationAccuracyBest
      @location_manager.pausesLocationUpdatesAutomatically = false if @location_manager.respond_to?(:pausesLocationUpdatesAutomatically)
      self
    end
    attr_reader :location_manager
    attr_accessor :listener

    def process options = {}
      @location_manager.purpose = options[:purpose] if options[:purpose]
    end

    def go
      @location_manager.startUpdatingLocation
    end

    def pause time
      @location_manager.allowDeferredLocationUpdatesUntilTraveled 10000, timeout: time
    end

    def reset
      @location_manager.stopUpdatingLocation
      @location_manager.startUpdatingLocation
    end

    def clear
      @location_manager.stopUpdatingLocation
    end

    def update location
      @listener.call Location.alloc.init(location)
    end

    def error code
    end

    def switch_to_accuracy accuracy
      @location_manager.desiredAccuracy = accuracy
      reset
    end

    def switch_to_distance_filter distance
      @location_manager.distanceFilter = distance
      reset
    end

  end
end
