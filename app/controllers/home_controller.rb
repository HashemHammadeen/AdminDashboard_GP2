class HomeController < ApplicationController
  def index
    if mall_admin_signed_in?
      redirect_to mall_admin_root_path
    elsif shop_admin_signed_in?
      redirect_to shop_admin_root_path
    end
    # Otherwise render the login chooser
  end
end
