describe LoginScreen do
  tests LoginScreen

  def login_screen
    @login_screen ||= LoginScreen.new(nav_bar: true).tap {|login_screen| login_screen.on_load }
  end

  def controller
    login_screen.navigationController
  end

  after { @login_screen = nil }

  it "has a navigationController" do
    login_screen.navigationController.should.be.kind_of(UINavigationController)
  end

  it "has a text field for id" do
    view("username_field").should.be.kind_of(UITextField)
  end

  it "has a text field for password" do
    view("password_field").should.be.kind_of(UITextField)
  end

  it "has a left nav bar button" do
    login_screen.navigationItem.leftBarButtonItem.should.be.kind_of(UIBarButtonItem)
  end

  it "has a right nav bar button" do
    login_screen.navigationItem.rightBarButtonItem.should.be.kind_of(UIBarButtonItem)
  end

end
