class QrsController < ApplicationController
  before_action :authenticate_any_admin!
  load_and_authorize_resource class: "Qr"
  layout "dashboard"

  def index
    @qrs = @qrs.where(shop_id: current_shop.shop_id).includes(:user) if current_shop
    @qrs = @qrs.includes(:user, :shop) if current_mall
  end

  def show; end
  def new
    @users = User.all
  end

  def edit; end

  def create
    @qr.shop_id = current_shop.id if current_shop
    
    # Auto-generate QR data and set expiry
    @qr.qr_code_data = "QR-#{@qr.shop_id}-#{SecureRandom.hex(6)}"
    @qr.expires_at = 1.year.from_now

    respond_to do |format|
      if @qr.save
        format.html { redirect_to @qr, notice: "QR code was successfully generated." }
      else
        @users = User.all
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @qr.update(qr_params)
        format.html { redirect_to @qr, notice: "QR code was successfully updated.", status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @qr.destroy!
    redirect_to qrs_path, notice: "QR code was successfully deleted.", status: :see_other
  end

  private

  def qr_params
    params.expect(qr: [:user_id, :shop_id])
  end
end
