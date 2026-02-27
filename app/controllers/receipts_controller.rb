class ReceiptsController < ApplicationController
  before_action :authenticate_any_admin!
  load_and_authorize_resource
  layout "dashboard"

  def index
    @receipts = @receipts.where(shop_id: current_shop.id).includes(:user).order(created_at: :desc) if current_shop
    @receipts = @receipts.includes(:user, :shop).order(created_at: :desc) if current_mall
  end

  def show; end
  def edit; end

  def update
    respond_to do |format|
      if @receipt.update(receipt_params)
        format.html { redirect_to @receipt, notice: "Receipt was successfully updated.", status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @receipt.destroy!
    redirect_to receipts_path, notice: "Receipt was successfully deleted.", status: :see_other
  end

  private

  def receipt_params
    params.expect(receipt: [:status])
  end
end
