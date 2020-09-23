class CommentsController < ApplicationController
  def create
   comment = Comment.new(comment_params)
    if comment.save
      redirect_to topics_path, success: 'コメント投稿しました'
    else
      redirect_to topics_path, danger: 'コメント投稿に失敗しました。'
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :topic_id).to_h.merge(user_id: current_user.id)
    end
end
