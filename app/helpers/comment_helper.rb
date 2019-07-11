module CommentHelper
  class CommentError < ArgumentError
  end

  def create_comment(node, user, body)
    @comment = node.add_comment(uid: user.uid, body: body)
    if user && @comment.save
      ActionCable.server.broadcast 'room_channel', message: 'checkpoint 2'
      @comment.notify user
      ActionCable.server.broadcast 'room_channel', message: "checkpoint 12"
      return @comment
    else
      raise CommentError
    end
  end
end
