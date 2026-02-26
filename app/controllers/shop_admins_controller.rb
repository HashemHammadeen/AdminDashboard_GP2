class ShopAdminsController < ApplicationController
  before_action :authenticate_shop_admin!
  before_action :set_shop_admin, only: %i[show edit update]
  layout "dashboard"

  def index
    @shop_admins = ShopAdmin.where(shop_id: current_shop_admin.shop.id)
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @shop_admin.update(shop_admin_params)
        format.html { redirect_to @shop_admin, notice: "Shop admin was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @shop_admin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shop_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_shop_admin
    @shop_admin = ShopAdmin.where(shop_id: current_shop_admin.shop.id).find(params.expect(:id))
  end

  def shop_admin_params
    params.expect(shop_admin: [:name, :email, :phone, :password, :password_confirmation])
  end
end
