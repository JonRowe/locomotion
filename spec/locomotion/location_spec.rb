describe 'location' do
  before do
    @cllocation = CLLocation.alloc.initWithCoordinate CLLocationCoordinate2D.new(1,2),
      altitude: 10,
      horizontalAccuracy: 4,
      verticalAccuracy: 3,
      course: 1.3,
      speed: 1.5,
      timestamp: Time.at(123456789)
    @location = Locomotion::Location.alloc.init @cllocation
  end

  it 'exposes latitude' do
    @location.latitude.should.equal 1
  end
  it 'exposes longitude' do
    @location.longitude.should.equal 2
  end
  it 'exposes speed' do
    @location.speed.should.equal 1.5
  end
  it 'exposes heading' do
    @location.heading.should.equal 1.3
  end
  it 'exposes time' do
    @location.time.should.equal Time.at(123456789)
  end
  it 'exposes accuracy' do
    @location.accuracy.should.equal 4
  end

  it 'formats nicely' do
    @location.to_s.should.equal "<Location 1.0 2.0 >"
    @location.to_s.should.equal @location.inspect
  end

  it 'can calculate distance to another location' do
    another_location = Locomotion::Location.alloc.init CLLocation.alloc.initWithLatitude 1, longitude: 3
    @location.distance_to(another_location).should.be.close 111302.649, 0.001
  end

end
