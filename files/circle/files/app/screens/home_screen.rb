class HomeScreen < PM::Screen
  title App.name

  def load_view
    self.view = layout.view
  end

  def on_load
    set_nav_bar_button(:right, title: "Settings"._,
                               image: icon_image(:foundation, :widget, size: UIFont.labelFontSize),
                              action: :open_settings
                      ).tap {|btn| btn.accessibilityLabel = "Settings" }
  end

  def on_init
    # Fires only once, after the screen has been instantiated and all provided properties set.
    # A good place to do further initialization of instance variables or set your tab bar icon.
  end

  def will_appear
    # just before the view appears
  end

  def on_appear
    # just after the view appears
  end

  def will_disappear
    # just before the view disappears
  end

  def on_disappear
    # just after the view disappears
  end

  private

  def layout
    @layout ||= HomeLayout.new
  end

  def open_settings
    UIApplicationOpenSettingsURLString.nsurl.open
  end

end
