class RedeemTransactionsController < ApplicationController
  before_action :authenticate_shop_admin!
  before_action :set_redeem_transaction, only: %i[show edit update destroy]
  layout "dashboard"

  def index
    @redeem_transactions = current_shop_admin.shop.redeem_transactions.order(created_at: :desc)
  end

  def show
  end

  def new
    @redeem_transaction = current_shop_admin.shop.redeem_transactions.new
  end

  def edit
  end

  def create
    @redeem_transaction = current_shop_admin.shop.redeem_transactions.new(redeem_transaction_params)

    respond_to do |format|
      if @redeem_transaction.save
        format.html { redirect_to @redeem_transaction, notice: "Redeem transaction was successfully created." }
        format.json { render :show, status: :created, location: @redeem_transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @redeem_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @redeem_transaction.update(redeem_transaction_params)
        format.html { redirect_to @redeem_transaction, notice: "Redeem transaction was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @redeem_transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @redeem_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @redeem_transaction.destroy!
    respond_to do |format|
      format.html { redirect_to redeem_transactions_path, notice: "Redeem transaction was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_redeem_transaction
    @redeem_transaction = current_shop_admin.shop.redeem_transactions.find(params.expect(:id))
  end

  def redeem_transaction_params
    params.expect(redeem_transaction: [:user_id, :points_used, :discount_value, :verification_code, :status])
  end
end
