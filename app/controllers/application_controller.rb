class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  # CanCanCan: handle unauthorized access
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: "You are not authorized to perform this action."
  end

  # Helper to check role in views
  helper_method :mall_admin_signed_in?, :shop_admin_signed_in?,
                :current_admin, :current_mall, :current_shop,
                :current_mall_admin, :current_shop_admin

  before_action :set_tenant_by_subdomain

  # Returns the currently signed-in admin (either type)
  def current_mall_admin
    return @current_mall_admin if defined?(@current_mall_admin)
    @current_mall_admin = MallAdmin.find_by(id: session[:mall_admin_id]) if session[:mall_admin_id]
  end

  def current_shop_admin
    return @current_shop_admin if defined?(@current_shop_admin)
    @current_shop_admin = ShopAdmin.find_by(id: session[:shop_admin_id]) if session[:shop_admin_id]
  end

  def mall_admin_signed_in?
    current_mall_admin.present?
  end

  def shop_admin_signed_in?
    current_shop_admin.present?
  end

  def current_admin
    current_mall_admin || current_shop_admin
  end

  # Tenant helpers — returns the mall/shop the current admin belongs to
  def current_mall
    current_mall_admin&.mall
  end

  def current_shop
    current_shop_admin&.shop
  end

  private

  # CanCanCan uses this to determine the "current user" for ability checks
  def current_ability
    @current_ability ||= Ability.new(current_admin)
  end

  # Unified authentication — at least one admin must be signed in
  def authenticate_any_admin!
    unless mall_admin_signed_in? || shop_admin_signed_in?
      redirect_to root_path, alert: "You must sign in to continue."
      return
    end

    # Set context for Auditable hooks
    Current.admin = current_admin

    # Enforce Subdomain Tenant Isolation
    if @current_tenant_mall && current_admin
      admin_mall = current_mall_admin&.mall || current_shop_admin&.shop&.mall
      unless admin_mall == @current_tenant_mall
        sign_out_admin
        redirect_to root_path, alert: "Your account does not belong to this mall."
      end
    end
  end

  def authenticate_mall_admin!
    unless mall_admin_signed_in?
      redirect_to mall_admin_login_path, alert: "You must sign in as a Mall Admin."
      return
    end
    Current.admin = current_mall_admin
  end

  def authenticate_shop_admin!
    unless shop_admin_signed_in?
      redirect_to shop_admin_login_path, alert: "You must sign in as a Shop Admin."
      return
    end
    Current.admin = current_shop_admin
  end

  def sign_out_admin
    session.delete(:mall_admin_id)
    session.delete(:shop_admin_id)
    @current_mall_admin = nil
    @current_shop_admin = nil
  end

  def set_tenant_by_subdomain
    # In development, request.subdomain might be empty for 'mall1.localhost' due to TLD length defaults.
    # We fallback to parsing the host directly.
    subdomain = request.subdomain.presence || request.host.split('.').first

    if subdomain.present? && subdomain != "www" && subdomain != "localhost"
      @current_tenant_mall = Mall.find_by(subdomain: subdomain)
      unless @current_tenant_mall
        redirect_to root_url(host: "localhost"), alert: "Mall not found.", allow_other_host: true
      end
    end
  end
end
