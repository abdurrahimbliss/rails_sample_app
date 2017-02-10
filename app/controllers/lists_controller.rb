class ListsController < ApplicationController
  before_action :signed_in_user

  def index
    @user = User.find(params[:user_id])
    @lists = @user.lists.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:user_id])
    @list = @user.lists.find(params[:id])
    @feed_items = []
  end
end
