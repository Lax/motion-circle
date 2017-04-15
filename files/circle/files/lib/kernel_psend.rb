module Kernel

  def __psend__(msg)
    if msg.is_a? Array and msg[0].is_a? Array
      ([self] + msg).reduce(:__psend__)
    elsif msg.is_a? Array
      self.send *msg
    else
      self.send msg
    end
  end
  alias :psend :__psend__

end
