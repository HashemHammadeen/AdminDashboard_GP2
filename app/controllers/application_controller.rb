class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  def current_ability_user
    current_mall_admin || current_shop_admin
  end

  # Helper to check role in views
  helper_method :mall_admin_signed_in?, :shop_admin_signed_in?

  private

  def after_sign_in_path_for(resource)
    case resource
    when MallAdmin
      mall_admin_root_path
    when ShopAdmin
      shop_admin_root_path
    else
      root_path
    end
  end

  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end
end
