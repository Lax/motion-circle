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
    set_tab_bar_item item: "Home", title: "Home"._
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
