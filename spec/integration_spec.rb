describe 'integration into an app' do
  extend Bacon::Functional::API

  before do
    self.window = UIApplication.sharedApplication.keyWindow
  end

  it 'updates the location label' do
    view('location').should.satisfy { |label| label.text =~ /-?\d+\.\d+,-?\d+\.\d+/ }
  end

end
