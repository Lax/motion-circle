class CircleMessagesScreen < JSQMessagesScreen

  def on_load
    self.outgoingBubbleImageData ||= JSQMessagesBubbleImageFactory.new().outgoingMessagesBubbleImageWithColor UIColor.jsq_messageBubbleLightGrayColor
    self.incomingBubbleImageData ||= JSQMessagesBubbleImageFactory.new().incomingMessagesBubbleImageWithColor UIColor.jsq_messageBubbleGreenColor

    self.inputToolbar.contentView.textView.pasteDelegate = self
    self.collectionView.accessoryDelegate = self

    self.messages ||= []
    self.users ||= {}
    self.avatars ||= {}
  end

  def closePressed(sender)
    self.delegateModal.didDismissJSQDemoViewController self
  end

  # JSQMessagesViewController method overrides
  def didPressSendButton(button, withMessageText:text, senderId:senderId, senderDisplayName:senderDisplayName, date:date)
    # JSQSystemSoundPlayer.jsq_playMessageSentSound
    self.messages << JSQMessage.alloc.initWithSenderId(senderId, senderDisplayName:senderDisplayName, date:date, text:text)
    self.finishSendingMessageAnimated true
  end

  def didPressAccessoryButton(sender)
    self.inputToolbar.contentView.textView.resignFirstResponder
    sheet = UIActionSheet.alloc.initWithTitle "Media messages"._,
                                    delegate: self,
                           cancelButtonTitle: "Cancel"._,
                      destructiveButtonTitle: nil,
                           otherButtonTitles: "Get 1 Message"._, "Get 3 Messages"._, "Get 10 New Messages"._, nil

    sheet.showFromToolbar self.inputToolbar
  end

  # JSQMessages CollectionView DataSource
  def senderId
    UIDevice.currentDevice().identifierForVendor.UUIDString
  end

  def senderDisplayName
    senderId
  end

  def collectionView(collectionView, messageDataForItemAtIndexPath: indexPath)
    self.messages[indexPath.row]
  end

  def collectionView(collectionView, didDeleteMessageAtIndexPath: indexPath)
    self.messages.removeAtIndex(indexPath.row)
  end

  def collectionView(collectionView, messageBubbleImageDataForItemAtIndexPath: indexPath)
    case(self.messages[indexPath.row].senderId)
    when self.senderId
      return self.outgoingBubbleImageData
    else
      return self.incomingBubbleImageData
    end
  end

  def collectionView(collectionView, avatarImageDataForItemAtIndexPath: indexPath)
    sid = self.messages[indexPath.row].senderId

    self.avatar_for_sid(sid)
  end

  def collectionView(collectionView, attributedTextForCellTopLabelAtIndexPath:indexPath)
    # if indexPath.row % 3 == 0
      message = self.messages[indexPath.row]
      return JSQMessagesTimestampFormatter.sharedFormatter.attributedTimestampForDate message.date
    # end

    # return nil
  end

  def collectionView(collectionView, attributedTextForCellBottomLabelAtIndexPath:indexPath)
    return nil
  end

  def collectionView(collectionView, attributedTextForMessageBubbleTopLabelAtIndexPath:indexPath)
    message = self.messages[indexPath.row]

    if message.senderId == self.senderId
      return nil
    end

    if indexPath.row > 1
      previousMessage = self.messages[indexPath.row - 1]
      if previousMessage.senderId == message.senderId
        return nil
      end
    end

    return NSAttributedString.alloc.initWithString message.senderDisplayName
  end

  # UICollectionView DataSource
  def collectionView(collectionView, numberOfItemsInSection: section)
    self.messages.count
  end

  def collectionView(collectionView, cellForItemAtIndexPath: indexPath)
    super.tap do |cell|
      msg = self.messages[indexPath.row]
      if ! msg.isMediaMessage
        if msg.senderId == self.senderId
          cell.textView.textColor = UIColor.blackColor

          if HN::Profile.profile and NSUserDefaults.standardUserDefaults[:avatar]
            cell.avatarImageView.sd_setImageWithURL NSUserDefaults.standardUserDefaults[:avatar].nsurl,
                                  placeholderImage: nil
          end
        else
          cell.textView.textColor = UIColor.whiteColor
        end

        cell.textView.linkTextAttributes = {
          NSForegroundColorAttributeName => cell.textView.textColor,
          NSUnderlineStyleAttributeName  => NSUnderlineStyleSingle | NSUnderlinePatternSolid
        }
      end

      cell.accessoryButton.hidden = ! self.shouldShowAccessoryButtonForMessage(msg)
    end
  end

  def shouldShowAccessoryButtonForMessage(message)
    return message.isMediaMessage
  end

  def avatar_for_sid(sid)
    self.avatars[sid] ||= begin
      f = JSQMessagesAvatarImageFactory.new()

      f.avatarImageWithUserInitials sid,
                   backgroundColor: UIColor.colorWithWhite(0.85, alpha:1.0),
                         textColor: UIColor.colorWithWhite(0.60, alpha:1.0),
                              font: UIFont.systemFontOfSize(14.0)
    end
  end

end
