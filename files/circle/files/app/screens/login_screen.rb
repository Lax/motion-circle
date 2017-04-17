class LoginScreen < PM::Screen
  title "Login"._

  def load_view
    self.view = layout.view
  end

  def on_load
    @messages_btn = set_nav_bar_button(:right, title: "Messages"._, image: icon_image(:foundation, :comments, size: UIFont.labelFontSize), action: :show_messages).tap {|btn| btn.accessibilityLabel = "Messages" }

    @login_btn = set_nav_bar_button(:left, title: "Login"._, action: :toggole_login).tap {|btn| btn.accessibilityLabel = "Login" }
    update_nav_items
    update_avatar
  end

  def on_init
    set_tab_bar_item item: "HackerNews", title: "Profile"._
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
    @layout ||= LoginLayout.new.tap do |layout|
      layout.on :login do |username, password|
        login(username, password)
      end

      layout.on :save_login_info do |username, password|
        save_login_info(username, password)
      end
    end
  end

  def toggole_login
    if HN::Profile.profile
      mp "Toggle logout"
      logout
    else
      mp "Toggle login"
      login NSUserDefaults.standardUserDefaults[:username], NSUserDefaults.standardUserDefaults[:password]
    end
  end

  def logout
    mp "Logout %s" % HN::Profile.profile
    @login_btn.enabled = false

    HN::Profile.logout do
      update_nav_items
      update_avatar

      Motion::Blitz.success("Logout success"._)

      SugarCube::Timer.after 1 { @login_btn.enabled = true }
    end
  end

  def login(username, password)
    return if HN::Profile.profile

    @login_btn.enabled = false

    HN::Profile.login(username, password) do |profile|
      if profile
        mp "Login success %s %s" % [username, profile]

        update_nav_items
        update_avatar

        Motion::Blitz.success("Login success"._)

        layout.trigger :save_login_info, username, password

      else
        mp "Login failed %s" % username

        Motion::Blitz.error("Login failed"._)
      end

      SugarCube::Timer.after 2 { @login_btn.enabled = true }
    end
  end

  def save_login_info(username, password)
    NSUserDefaults.standardUserDefaults[:username] = username
    NSUserDefaults.standardUserDefaults[:password] = password
  end

  def update_nav_items
    if HN::Profile.profile
      # self.title = "Hi %s"._ % HN::Profile.profile
      @login_btn.title = "Logout"._
      @login_btn.accessibilityLabel = "Logout"
    else
      # self.title = "Login"._
      @login_btn.title = "Login"._
      @login_btn.accessibilityLabel = "Login"
    end
  end

  def update_avatar
    layout.get(:avatar).tap do |avatar|
      return unless avatar
      avatar.url = NSUserDefaults.standardUserDefaults[:avatar] if NSUserDefaults.standardUserDefaults[:avatar]

      if HN::Profile.profile
        HN::Profile.profile_info do |u|
          if user = u[:user].first
            email = user[:uemail].downcase
            digest = RmDigest::MD5.hexdigest(email)
            src = "https://www.gravatar.com/avatar/%s?s=200" % digest

            avatar.url = src

            NSUserDefaults.standardUserDefaults[:avatar] = src
          end
        end
      else
        NSUserDefaults.standardUserDefaults[:avatar] = nil
        avatar.url = nil
      end
    end
  end

  def show_messages
    open MessagesScreen.new(nav_bar: true)
  end

  def open_settings
    UIApplicationOpenSettingsURLString.nsurl.open
  end

end
