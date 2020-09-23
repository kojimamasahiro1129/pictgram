class TopicsController < ApplicationController
  
  def index
    @topics = Topic.all.includes(:favorite_users)
    @comment=Comment.new
    @comment_topics = current_user.comment_topics
    
  end
  
  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.new(topic_params)

    if @topic.save
      redirect_to topics_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
    
  end
  
  def destroy
    @favorite=Favorite.find_by(user_id:current_userid,topic_id:params[:topic_id])
    @favorite.destroy
    redirect_to topics_path,success:"いいねを取り消しました。"
  end

  private
  def topic_params
    params.require(:topic).permit(:image, :description)
  end
  
end
