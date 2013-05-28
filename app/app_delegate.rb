class AppDelegate

  def application application, didFinishLaunchingWithOptions: launchOptions
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    @controller = UIViewController.alloc.initWithNibName(nil, bundle:nil)

    @window.rootViewController = @controller
    @window.makeKeyAndVisible

    #@label = UILabel.alloc.initWithFrame [ [10,10], [300,100] ]
    #@label.setAccessibilityLabel 'username'
    #@label.setText '...'
    #@controller.view.addSubview @label

    true
  end
end
