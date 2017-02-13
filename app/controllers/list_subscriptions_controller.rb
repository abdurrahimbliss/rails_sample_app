class ListSubscriptionsController < ApplicationController
  before_action :signed_in_user

  def create
    @list = List.find(list_subscription_params[:list_id])
    list_subscription = ListSubscription.new(list_subscription_params)
    p list_subscription
    if list_subscription.save
      respond_to do |format|
        format.html { redirect_to @list }
        format.js
      end
    end
  end

  def destroy
    list_subscription = ListSubscription.find(params[:id])
    @list = List.find(list_subscription.list_id)
    if list_subscription.destroy
      respond_to do |format|
        format.html { redirect_to @list }
        format.js
      end
    end
  end

  private

    def list_subscription_params
      params.require(:list_subscription).permit(:list_id, :user_id)
    end
end
