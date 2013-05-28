module Locomotion
  class Delegate

    def initWith watchman
      @watchman = watchman
      self
    end
    attr_reader :watchman

    def locationManager manager, didUpdateToLocation: location, fromLocation: old_location
      @watchman.update location
    end

    def locationManager manager, didUpdateLocations: locations
      locations.each do |location|
        @watchman.update location
      end
    end

    def locationManager manager, didFailWithError: error
      if error.domain == KCLErrorDomain
        case error.code
        when KCLErrorDenied
          @watchman.error :denied
        when KCLErrorLocationUnknown
          manager.stopUpdatingLocation
          manager.startUpdatingLocation
        end
      end
    end

    def locationManager manager, didChangeAuthorizationStatus:status
      case status
      when KCLAuthorizationStatusRestricted
        @watchman.error :denied
      when KCLAuthorizationStatusDenied
        @watchman.error :denied
      end
    end

    def locationManager manager, didFinishDeferredUpdatesWithError: error
      @watchman.error :deferred_fail
    end

  end
end
