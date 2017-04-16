class MessagesScreen < CircleMessagesScreen
  title "Messages"._

  attr_accessor :more
  attr_accessor :news_items

  def on_load
    super

    set_nav_bar_button(:right, title: "Profile"._, image: icon_image(:foundation, :torso, size: UIFont.labelFontSize), action: :show_login).tap {|btn| btn.accessibilityLabel = "Profile" }
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

  # JSQMessagesViewController method overrides
  def didPressSendButton(button, withMessageText:text, senderId:senderId, senderDisplayName:senderDisplayName, date:date)
    super

    self.finishSendingMessage
  end

end
