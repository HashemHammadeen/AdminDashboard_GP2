class EarnTransactionsController < ApplicationController
  before_action :authenticate_any_admin!
  load_and_authorize_resource
  layout "dashboard"

  def index
    @earn_transactions = @earn_transactions.where(shop_id: current_shop.id).includes(:user).order(created_at: :desc) if current_shop
    @earn_transactions = @earn_transactions.includes(:user, :shop).order(created_at: :desc) if current_mall
  end

  def show; end
  def new; end
  def edit; end

  def create
    @earn_transaction.shop_id = current_shop.id if current_shop
    respond_to do |format|
      if @earn_transaction.save
        format.html { redirect_to @earn_transaction, notice: "Earn transaction created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @earn_transaction.update(earn_transaction_params)
        format.html { redirect_to @earn_transaction, notice: "Earn transaction updated.", status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @earn_transaction.destroy!
    redirect_to earn_transactions_path, notice: "Earn transaction deleted.", status: :see_other
  end

  private

  def earn_transaction_params
    params.expect(earn_transaction: [:user_id, :shop_id, :amount, :points_earned, :status])
  end
end
