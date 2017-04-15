class HomeLayout < MK::Layout

  def layout
    root :main
  end

  def main_style
    background_color :white.uicolor(0.95)
  end

end
