describe 'integration into an app' do
  extend Bacon::Functional::API

  before do
    self.window = UIApplication.sharedApplication.keyWindow
  end

  it 'updates the location label' do
    if CLLocationManager.authorizationStatus == KCLAuthorizationStatusAuthorized
      wait(1) {}
      view('location').should.satisfy { |label| label.text =~ /-?\d+\.\d+,-?\d+\.\d+/ }
    else
      warn "ENABLE LOCATION SERVICES FOR TEST"
      wait(5) {}
      view('location').should.satisfy { |label| label.text =~ /-?\d+\.\d+,-?\d+\.\d+/ }
    end
  end

end
