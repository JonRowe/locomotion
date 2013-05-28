describe 'he who watches the watchman (the delegate)' do

  before do
    watchman = Class.new do
      def update location
        @locations ||= []
        @locations << location
      end
      def error error
        @errors ||= []
        @errors << error
      end
      attr_reader :locations, :errors
    end
    @watchman = watchman.alloc.init
    @delegate = Locomotion::Delegate.alloc.initWith @watchman
  end

  it 'handles updateToLocation' do
    @delegate.locationManager nil, didUpdateToLocation: "location", fromLocation: "old location"
    @watchman.locations.should.equal ["location"]
  end

  it 'handles didUpdateLocations' do
    @delegate.locationManager nil, didUpdateLocations: [1,2]
    @watchman.locations.should.equal [2]
  end

  it 'handles didFailWithError: KCLErrorDenied by notifying the watchman' do
    @delegate.locationManager nil, didFailWithError: NSError.errorWithDomain(KCLErrorDomain, code: KCLErrorDenied, userInfo: {})
    @watchman.errors.should.equal [:denied]
  end

  it 'handles didFailWithError: other by ignoring' do
    @delegate.locationManager nil, didFailWithError: NSError.errorWithDomain('other', code: 0, userInfo: {})
    @watchman.errors.should.equal nil
  end

  it 'handles didFailWithError: KCLErrorLocationUnknown by restarting' do
    manager = Class.new do
      def startUpdatingLocation
        commands << :start
      end
      def stopUpdatingLocation
        commands << :stop
      end
      def commands
        @commands ||= []
      end
    end.new
    @delegate.locationManager manager, didFailWithError: NSError.errorWithDomain(KCLErrorDomain, code: KCLErrorLocationUnknown, userInfo: {})
    manager.commands.should.equal [:stop,:start]
  end

  it 'handles didChangeAuthorizationStatus: restricted by notifying the watchman' do
    @delegate.locationManager nil, didChangeAuthorizationStatus: KCLAuthorizationStatusRestricted
    @watchman.errors.should.equal [:denied]
  end

  it 'handles didChangeAuthorizationStatus denied notifying the watchman' do
    @delegate.locationManager nil, didChangeAuthorizationStatus: KCLAuthorizationStatusDenied
    @watchman.errors.should.equal [:denied]
  end

  it 'handles didChangeAuthorizationStatus other' do
    @delegate.locationManager nil, didChangeAuthorizationStatus: nil
    @watchman.errors.should.equal nil
  end
end
