class StampTransactionsController < ApplicationController
  before_action :authenticate_shop_admin!
  before_action :set_stamp_transaction, only: %i[show edit update destroy]
  layout "dashboard"

  def index
    @stamp_transactions = StampTransaction.where(shop_id: current_shop_admin.shop.id).order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @stamp_transaction.update(stamp_transaction_params)
        format.html { redirect_to @stamp_transaction, notice: "Stamp transaction was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @stamp_transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stamp_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @stamp_transaction.destroy!
    respond_to do |format|
      format.html { redirect_to stamp_transactions_path, notice: "Stamp transaction was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_stamp_transaction
    @stamp_transaction = StampTransaction.where(shop_id: current_shop_admin.shop.id).find(params.expect(:id))
  end

  def stamp_transaction_params
    params.expect(stamp_transaction: [:user_id, :stamp_id, :stamps_count, :transaction_type, :receipt_id])
  end
end
