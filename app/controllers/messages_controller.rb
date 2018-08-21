class MessagesController < ApplicationController
  before_action :find_post, only: :create

  def create
    @message = Message.new(post_params)
    @message.user = current_user
    @message.post_id = @post.id
    @message.save

    redirect_to group_post_path(@post.group, @post)
  end

  private

  def post_params
    params.require(:message).permit(:message)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end
