class MallDashboardsController < ApplicationController
  # This ensures ONLY logged-in Mall Admins can see this page
  before_action :authenticate_mall_admin!

  def show
    # You can access the specific mall through the logged-in admin
    @mall = current_mall_admin.mall
  end
end