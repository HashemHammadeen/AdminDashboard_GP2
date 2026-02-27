class HomeController < ApplicationController
  def index
    if @current_tenant_mall
      # We are on a specific mall's subdomain
      if mall_admin_signed_in? || shop_admin_signed_in?
        redirect_to after_sign_in_path_for(current_admin)
      end
      # Otherwise render the specific mall's login selector (default index.html.erb)
    else
      # We have no subdomain, so this is the global portal
      @malls = Mall.all
      render "global_portal"
    end
  end
end
