class ShopDashboardsController < ApplicationController
  # This ensures ONLY logged-in Shop Admins can see this page
  before_action :authenticate_shop_admin!

  def show
    @shop = current_shop_admin.shop
  end
end