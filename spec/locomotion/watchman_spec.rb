describe 'the watchman' do

  before do
    test_manager = Class.new do
      attr_accessor :delegate, :distanceFilter, :desiredAccuracy, :purpose

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
    end
    @watchman = Locomotion::Watchman.alloc.init test_manager
  end

  it 'initialises the location manager with the minimum distance filter' do
    @watchman.location_manager.distanceFilter.should.equal KCLDistanceFilterNone
  end
  it 'initialises the location manager with the best accuracy' do
    @watchman.location_manager.desiredAccuracy.should.equal KCLLocationAccuracyBest
  end
  it 'sets the delegate to be a locomotion delegate' do
    @watchman.location_manager.should.satisfy do |lm|
      lm.delegate.class == Locomotion::Delegate and
      lm.delegate.watchman == @watchman
    end
  end

  it 'processes purpose' do
    @watchman.process purpose: 'My Purpose'
    @watchman.location_manager.purpose.should.equal 'My Purpose'
  end

  it 'accepts listeners' do
    @watchman.listeners << :a
    @watchman.listeners.should.equal [:a]
  end

  it 'tells location manager to start on go' do
    @watchman.go
    @watchman.location_manager.commands.should.equal [:start]
  end
  it 'tells location manager to defer on pause' do
    @watchman.pause 42
    @watchman.location_manager.commands.should.equal [[:defer,10000,42]]
  end
  it 'tells location manager to stop on clear' do
    @watchman.clear
    @watchman.location_manager.commands.should.equal [:stop]
  end

  it 'tells listeners on update' do
    @watchman.listeners << proc { |location| @location = location }
    @watchman.update [1,1]
    @location.should.equal [1,1]
  end

end