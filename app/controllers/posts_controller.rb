class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_group, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :member_required, only: [:new, :create]

  def show
    @messages = @post.messages
    @message = Message.new
  end

  def new
    @post = @group.posts.build
  end

  def create
    @post = @group.posts.new(post_params)
    @post.author = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy

    redirect_to group_path(@group)
  end

  private

  def find_group
    @group = Group.find(params[:group_id])
  end

  def find_post
    @post = @group.posts.includes(:messages).find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end

  def member_required
    if !current_user.is_member_of?(@group)
      flash[:warning] = "You are not member pf this group!"
      redirect_to group_path(@group)
    end
  end
end
