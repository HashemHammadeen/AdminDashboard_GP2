class ShopAdminsController < ApplicationController
  before_action :authenticate_any_admin!
  load_and_authorize_resource except: [:new, :create]
  layout "dashboard"

  def index
    @shop_admins = @shop_admins.where(shop_id: current_shop.id) if current_shop
    @shop_admins = @shop_admins.includes(:shop)
  end

  def show; end

  def new
    @shop_admin = ShopAdmin.new
    # If a mall admin creates one, they will pass shop_id in params
    @shop_admin.shop_id = params[:shop_id] if params[:shop_id].present? && current_mall_admin
    authorize! :new, @shop_admin
  end

  def create
    @shop_admin = ShopAdmin.new(shop_admin_params)
    
    # Securely override the shop_id depending on who is creating the staff member
    if current_shop
      @shop_admin.shop_id = current_shop.id
    end
    
    # Must authorize the newly built record securely (stops MallAdmin A from adding staff to Mall B's Shop)
    authorize! :create, @shop_admin

    respond_to do |format|
      if @shop_admin.save
        format.html { redirect_to (current_mall_admin ? shop_path(@shop_admin.shop_id) : shop_admins_path), notice: "Shop admin was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    # If the user is passing password fields but they are blank, strip them out so Devise doesn't try to change the password
    if params[:shop_admin][:password].blank? && params[:shop_admin][:password_confirmation].blank?
      params[:shop_admin].delete(:password)
      params[:shop_admin].delete(:password_confirmation)
    end

    respond_to do |format|
      if @shop_admin.update(shop_admin_params)
        format.html { redirect_to (current_mall_admin ? shop_path(@shop_admin.shop_id) : shop_admins_path), notice: "Shop admin was successfully updated.", status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def toggle_active
    @shop_admin.update(is_active: !@shop_admin.is_active)
    respond_to do |format|
      format.html { redirect_back fallback_location: (current_mall_admin ? shop_path(@shop_admin.shop_id) : shop_admins_path), notice: "Status updated successfully." }
    end
  end

  private

  def shop_admin_params
    # We only permit shop_id if the current_user is a MallAdmin creating staff for a shop.
    permitted = [:name, :email, :phone, :password, :password_confirmation]
    permitted << :shop_id if current_mall_admin
    params.expect(shop_admin: permitted)
  end
end
