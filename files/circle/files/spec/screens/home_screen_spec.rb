describe HomeScreen do
  tests HomeScreen

  before { UIView.setAnimationsEnabled false }

  def home_screen
    @home_screen ||= HomeScreen.new(nav_bar: true).tap {|home_screen| home_screen.on_load }
  end

  def controller
    home_screen.navigationController
  end

  after { @home_screen = nil }

  it "has a navigationController" do
    home_screen.navigationController.should.be.kind_of(UINavigationController)
  end

  it "has a right nav bar button" do
    home_screen.navigationItem.rightBarButtonItem.should.be.kind_of(UIBarButtonItem)
  end

  it "has right nav bar buttons" do
    home_screen.navigationItem.rightBarButtonItems.size.should >= 1
    home_screen.navigationItem.rightBarButtonItems.each do |item|
      item.should.be.kind_of(UIBarButtonItem)
    end
  end

  it "has Settings button" do
    view("Settings").should.be.kind_of(UINavigationButton)
  end

end
