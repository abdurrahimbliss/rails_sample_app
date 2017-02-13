class ListMembershipsController < ApplicationController
  include ApplicationHelper
  before_action :signed_in_user

  def create
    list_membership = ListMembership.new(list_membership_params)
    if list_membership.save
      @user = User.find(list_membership.user_id)
      list_memberships(@user)
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    list_membership = ListMembership.find(params[:id])
    if list_membership.destroy
      @user = User.find(list_membership.user_id)
      list_memberships(@user)
      respond_to do |format|
        format.js
      end
    end
  end

  private

    def list_membership_params
      params.require(:list_membership).permit(:list_id, :user_id)
    end
end
