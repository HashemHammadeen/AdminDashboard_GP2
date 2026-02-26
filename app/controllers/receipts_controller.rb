class ReceiptsController < ApplicationController
  before_action :authenticate_shop_admin!
  before_action :set_receipt, only: %i[show edit update destroy]
  layout "dashboard"

  def index
    @receipts = current_shop_admin.shop.receipts.order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @receipt.update(receipt_params)
        format.html { redirect_to @receipt, notice: "Receipt was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @receipt }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @receipt.destroy!
    respond_to do |format|
      format.html { redirect_to receipts_path, notice: "Receipt was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_receipt
    @receipt = current_shop_admin.shop.receipts.find(params.expect(:id))
  end

  def receipt_params
    params.expect(receipt: [:status])
  end
end
