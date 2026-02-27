class ShopsController < ApplicationController
  before_action :authenticate_any_admin!
  load_and_authorize_resource
  layout "dashboard"

  def index
    @shops = @shops.where(mall_id: current_mall.id).includes(:mall, :category) if current_mall
    @shops = @shops.includes(:mall, :category)
  end

  def show; end
  def new; end
  def edit; end

  def create
    @shop.mall_id = current_mall.id if current_mall
    respond_to do |format|
      if @shop.save
        format.html { redirect_to @shop, notice: "Shop was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @shop.update(shop_params)
        format.html { redirect_to @shop, notice: "Shop was successfully updated.", status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @shop.destroy!
    redirect_to shops_path, notice: "Shop was successfully destroyed.", status: :see_other
  end

  # Store Approval — activate a shop
  def approve
    @shop = Shop.find(params[:id])
    authorize! :manage, @shop
    @shop.update!(is_active: true)
    redirect_to @shop, notice: "Shop has been approved and activated."
  end

  # Store Control — deactivate a shop
  def deactivate
    @shop = Shop.find(params[:id])
    authorize! :manage, @shop
    @shop.update!(is_active: false)
    redirect_to @shop, notice: "Shop has been deactivated."
  end

  private

  def shop_params
    params.expect(shop: [:mall_id, :name, :category_id, :logo_url, :cover_image_url, :bio, :website_url, :social_links, :is_active])
  end
end
