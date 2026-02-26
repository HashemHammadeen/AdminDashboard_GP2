class QrsController < ApplicationController
  before_action :authenticate_shop_admin!
  before_action :set_qr, only: %i[show edit update destroy]
  layout "dashboard"

  def index
    @qrs = Qr.where(shop_id: current_shop_admin.shop.id).order(created_at: :desc)
  end

  def show
  end

  def new
    @qr = Qr.new(shop_id: current_shop_admin.shop.id)
  end

  def edit
  end

  def create
    @qr = Qr.new(qr_params)
    @qr.shop = current_shop_admin.shop

    respond_to do |format|
      if @qr.save
        format.html { redirect_to @qr, notice: "QR was successfully created." }
        format.json { render :show, status: :created, location: @qr }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @qr.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @qr.update(qr_params)
        format.html { redirect_to @qr, notice: "QR was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @qr }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @qr.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @qr.destroy!
    respond_to do |format|
      format.html { redirect_to qrs_path, notice: "QR was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_qr
    @qr = Qr.where(shop_id: current_shop_admin.shop.id).find(params.expect(:id))
  end

  def qr_params
    params.expect(qr: [:user_id, :qr_code_data, :expires_at])
  end
end
