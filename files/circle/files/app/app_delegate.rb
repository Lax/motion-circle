class AppDelegate < PM::Delegate
  status_bar true, animation: [:none, :slide, :fade].sample

  def on_load(app, options)
    return true if RUBYMOTION_ENV == "test"
    open_tab_bar HomeScreen.new(nav_bar: true), LoginScreen.new(nav_bar: true)

    UINavigationBar.appearance.tintColor = :white.uicolor
    UINavigationBar.appearance.barTintColor = [255, 102, 0].uicolor
    UINavigationBar.appearance.setTitleTextAttributes(
      NSForegroundColorAttributeName => :white.uicolor,
      NSBaselineOffsetAttributeName => 0,
      NSFontAttributeName => 'HelveticaNeue-Bold'.uifont(UIFont.labelFontSize)
    )
    UINavigationBar.appearance.setBackIndicatorImage icon_image(:awesome, :arrow_circle_left, size: UIFont.labelFontSize, color: :white.uicolor)
    UINavigationBar.appearance.setBackIndicatorTransitionMaskImage icon_image(:awesome, :arrow_circle_o_left, size: UIFont.labelFontSize, color: :white.uicolor)
  end

  def on_open_url(args = {})
    mp args
  end

end
