module Locomotion
  class << self

    def accuracy= level
      watchman.switch_to_accuracy({
          best_for_navigation: KCLLocationAccuracyBestForNavigation,
          best:                KCLLocationAccuracyBest,
          nearest_ten:         KCLLocationAccuracyNearestTenMeters,
          nearest_hundred:     KCLLocationAccuracyHundredMeters,
          nearest_km:          KCLLocationAccuracyKilometer,
          nearest_3km:         KCLLocationAccuracyThreeKilometers
        }.fetch(level, KCLLocationAccuracyBest))
    end

    def distance_filter= distance
      watchman.switch_to_distance_filter distance || KCLDistanceFilterNone
    end

    def watch opts = {}, &block
      watchman.process opts
      watchman.listener = block
      watchman.go
    end

    def defer time
      watchman.pause time
    end

    def stop
      watchman.clear
    end

    def watchman
      @watchman ||= Watchman.alloc.init
    end

  end
end
