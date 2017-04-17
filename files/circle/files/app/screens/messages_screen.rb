class MessagesScreen < CircleMessagesScreen
  title "Messages"._

  attr_accessor :more
  attr_accessor :news_items

  def on_load
    super
  end

  def on_init
    set_tab_bar_item item: "Messages", title: "Messages"._
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
