class NavigationScreen < ProMotion::TableScreen

  def table_data
    [{
      title: nil,
      cells: [{
        title: 'Home'._,
        action: :swap_center_controller,
        arguments: HomeScreen
      }, {
        title: 'Messages'._,
        action: :swap_center_controller,
        arguments: MessagesScreen
      }, {
        title: 'Profile'._,
        action: :swap_center_controller,
        arguments: LoginScreen
      }]
    }]
  end

  def swap_center_controller(screen_class)
    app_delegate.menu.center_controller = screen_class.new(nav_bar: true)
  end

end
