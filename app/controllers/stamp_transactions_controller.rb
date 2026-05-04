class StampTransactionsController < ApplicationController
  before_action :authenticate_any_admin!
  load_and_authorize_resource
  layout "dashboard"

  def index
    @stamp_transactions = @stamp_transactions.where(shop_id: current_shop.id).includes(:user, :stamp_program).order(created_at: :desc) if current_shop
    @stamp_transactions = @stamp_transactions.includes(:user, :stamp_program, :shop).order(created_at: :desc) if current_mall
  end

  def show; end
  def edit; end

  def update
    respond_to do |format|
      if @stamp_transaction.update(stamp_transaction_params)
        format.html { redirect_to @stamp_transaction, notice: "Stamp transaction updated.", status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @stamp_transaction.destroy!
    redirect_to stamp_transactions_path, notice: "Stamp transaction deleted.", status: :see_other
  end

  private

  def stamp_transaction_params
    params.expect(stamp_transaction: [:status])
  end
end
