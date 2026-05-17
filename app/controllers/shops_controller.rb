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
    upload_images_for(@shop)
    respond_to do |format|
      if @shop.save
        format.html { redirect_to @shop, notice: "Shop was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    @shop.assign_attributes(shop_params)
    upload_images_for(@shop)
    respond_to do |format|
      if @shop.save
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

  def upload_images_for(shop)
    require_dependency Rails.root.join("app/services/supabase_storage_service.rb")

    if shop.logo_file.present?
      ext = File.extname(shop.logo_file.original_filename)
      path = "shops/#{shop.id || SecureRandom.uuid}/logo#{ext}"
      url = ::SupabaseStorageService.upload(shop.logo_file, path)
      shop.logo_url = url if url
    end

    if shop.cover_image_file.present?
      ext = File.extname(shop.cover_image_file.original_filename)
      path = "shops/#{shop.id || SecureRandom.uuid}/cover#{ext}"
      url = ::SupabaseStorageService.upload(shop.cover_image_file, path)
      shop.cover_image_url = url if url
    end
  end

  def shop_params
    params.expect(shop: [:mall_id, :name, :category_id, :logo_url, :cover_image_url, :bio, :website_url, :facebook, :instagram, :x, :is_active, :logo_file, :cover_image_file])
  end
end

