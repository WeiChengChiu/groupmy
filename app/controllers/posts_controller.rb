class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_group, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_post, only: [:edit, :update, :destroy]

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
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
