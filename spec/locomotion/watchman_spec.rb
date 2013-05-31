describe 'the watchman' do

  before do
    @watchman = Locomotion::Watchman.alloc.init FakeLocationManager
    @watchman.location_manager.reset
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

  it 'accepts a listener' do
    @watchman.listener = :a
    @watchman.listener.should.equal :a
  end

  it 'tells location manager to start on go' do
    @watchman.go
    @watchman.location_manager.commands.should.equal [:start]
  end

  it 'tells location manager to defer on pause' do
    @watchman.pause 42
    @watchman.location_manager.commands.should.equal [[:defer,10000,42]]
  end

  it 'tells location manager to stop then start on reset' do
    @watchman.reset
    @watchman.location_manager.commands.should.equal [:stop,:start]
  end

  it 'tells location manager to stop on clear' do
    @watchman.clear
    @watchman.location_manager.commands.should.equal [:stop]
  end

  it 'tells listeners on update' do
    @watchman.listener = proc { |location| @location = location }
    @watchman.update CLLocation.alloc.initWithLatitude 1, longitude: 1
    @location.should.satisfy { |l| l.latitude == 1 && l.longitude == 1 }
  end

  { switch_to_accuracy: :desiredAccuracy, switch_to_distance_filter: :distanceFilter }.each do |method,setting|
    it "can configure #{setting} but resets afterwards" do
      @watchman.send(method,42)
      @watchman.location_manager.commands.should.equal [[setting,42],:stop,:start]
    end
  end
end
