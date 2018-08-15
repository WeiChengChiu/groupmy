class GroupsController < ApplicationController
  before_action :find_user_group, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show
    @posts = @group.posts
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.build(groups_params)

    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
    @posts = @group.posts
  end

  def update
    if @group.update(groups_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def destroy
    @group.destroy

    redirect_to groups_path
  end

  private

  def groups_params
    params.require(:group).permit(:title, :description)
  end

  def find_user_group
    @group = current_user.groups.find(params[:id])
  end

end
