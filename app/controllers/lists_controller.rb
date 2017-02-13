class ListsController < ApplicationController
  before_action :signed_in_user

  def index
    @user = User.find(params[:user_id])
    @lists = @user.lists
    subscriptions = @user.subscriptions
    @lists.push(subscriptions).flatten!
    @memberships = @user.memberships
  end

  def show
    @user = User.find(params[:user_id])
    @list = @user.lists.find(params[:id])
    @feed_items = @list.feed.paginate(page: params[:page])
  end

  def create
    @user = User.find(params[:user_id])
    @list = @user.lists.build(list_params)
    if @list.save
      flash[:success] = "List successfully created"
      redirect_to user_list_path(@user, @list)
    else
      render 'index'
    end
  end

  def members
    @user = User.find(params[:user_id])
    @list = @user.lists.find(params[:list_id])
    @members = @list.members.paginate(page: params[:page])
  end

  private

    def list_params
      params.require(:list).permit(:name, :description)
    end
end
