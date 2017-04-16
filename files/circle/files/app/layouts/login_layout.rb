class LoginLayout < MK::Layout

  def layout
    root :main do
      add UIView, :id_container do
        add UITextField, :username_field do
          delegate self
        end
        add UITextField, :password_field do
          delegate self
        end
      end
      add UIImageView, :avatar
    end
  end

  def main_style
    background_color :white.uicolor(0.95)
  end

  def id_container_style
    constraints do
      left.equals(:superview)
      right.equals(:superview)
      center_y.equals(:superview)
      bottom.is >= :username_field
      bottom.is >= :password_field
    end
  end

  def username_field_style
    placeholder 'username'._
    text_alignment UITextAlignmentCenter
    enables_return_key_automatically true

    text NSUserDefaults.standardUserDefaults[:username] if NSUserDefaults.standardUserDefaults[:username]

    accessibility_label 'username_field'

    constraints do
      left.equals(:superview)
      right.equals(:superview)
      top.equals(:superview)
      height.is >= 30
    end
  end

  def password_field_style
    placeholder 'password'._
    text_alignment UITextAlignmentCenter
    enables_return_key_automatically true
    secure_text_entry true

    text NSUserDefaults.standardUserDefaults[:password] if NSUserDefaults.standardUserDefaults[:password]

    accessibility_label 'password_field'

    constraints do
      left.equals(:superview)
      right.equals(:superview)
      top.equals(:username_field, :bottom).plus(5)
      height.equals(:username_field)
    end
  end

  def avatar_style
    constraints do
      size [80, 80]
      center_x.equals(:superview)
      bottom.equals(:id_container, :top).minus(10)
    end

    layer do
      cornerRadius 6
      masks_to_bounds true
    end
  end

  # Delegate
  def textFieldShouldReturn(field)
    field.resignFirstResponder

    case field
    when get(:username_field)
      get(:password_field).becomeFirstResponder

    when get(:password_field)
      trigger_login

    else
    end
  end

  private

  def trigger_login
    trigger :login, get(:username_field).text.to_s, get(:password_field).text.to_s
  end

end
