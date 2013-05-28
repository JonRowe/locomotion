class AppDelegate

  def application application, didFinishLaunchingWithOptions: launchOptions
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    @controller = UIViewController.alloc.initWithNibName(nil, bundle:nil)

    @window.rootViewController = @controller
    @window.makeKeyAndVisible

    @label = UILabel.alloc.initWithFrame [ [10,10], [300,100] ]
    @label.setAccessibilityLabel 'location'
    @label.setText '...'
    @controller.view.addSubview @label

    Locomotion.watch purpose: 'Testing...' do |location|
      @label.setText "#{location.latitude},#{location.longitude}"
    end

    true
  end
end
