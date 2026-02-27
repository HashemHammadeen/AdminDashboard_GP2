class RedeemTransactionsController < ApplicationController
  before_action :authenticate_any_admin!
  load_and_authorize_resource
  layout "dashboard"

  def index
    @redeem_transactions = @redeem_transactions.where(shop_id: current_shop.id).includes(:user).order(created_at: :desc) if current_shop
    @redeem_transactions = @redeem_transactions.includes(:user, :shop).order(created_at: :desc) if current_mall
  end

  def show; end
  def new; end
  def edit; end

  def create
    @redeem_transaction.shop_id = current_shop.id if current_shop
    respond_to do |format|
      if @redeem_transaction.save
        format.html { redirect_to @redeem_transaction, notice: "Redeem transaction created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @redeem_transaction.update(redeem_transaction_params)
        format.html { redirect_to @redeem_transaction, notice: "Redeem transaction updated.", status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @redeem_transaction.destroy!
    redirect_to redeem_transactions_path, notice: "Redeem transaction deleted.", status: :see_other
  end

  private

  def redeem_transaction_params
    params.expect(redeem_transaction: [:user_id, :shop_id, :points_redeemed, :reward_description, :status])
  end
end
