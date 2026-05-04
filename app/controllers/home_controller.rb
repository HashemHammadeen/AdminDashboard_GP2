class HomeController < ApplicationController
  def index
    if @current_tenant_mall
      # We are on a specific mall's subdomain
      if mall_admin_signed_in?
        redirect_to mall_admin_root_path
      elsif shop_admin_signed_in?
        redirect_to shop_admin_root_path
      end
      # Otherwise render the specific mall's login selector (default index.html.erb)
    else
      # We have no subdomain, so this is the global portal
      @malls = Mall.all
      render "global_portal"
    end
  end
end
