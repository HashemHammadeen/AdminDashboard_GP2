class EarnTransactionsController < ApplicationController
  before_action :authenticate_shop_admin!
  before_action :set_earn_transaction, only: %i[show edit update destroy]
  layout "dashboard"

  def index
    @earn_transactions = current_shop_admin.shop.earn_transactions.order(created_at: :desc)
  end

  def show
  end

  def new
    @earn_transaction = current_shop_admin.shop.earn_transactions.new
  end

  def edit
  end

  def create
    @earn_transaction = current_shop_admin.shop.earn_transactions.new(earn_transaction_params)

    respond_to do |format|
      if @earn_transaction.save
        format.html { redirect_to @earn_transaction, notice: "Earn transaction was successfully created." }
        format.json { render :show, status: :created, location: @earn_transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @earn_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @earn_transaction.update(earn_transaction_params)
        format.html { redirect_to @earn_transaction, notice: "Earn transaction was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @earn_transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @earn_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @earn_transaction.destroy!
    respond_to do |format|
      format.html { redirect_to earn_transactions_path, notice: "Earn transaction was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_earn_transaction
    @earn_transaction = current_shop_admin.shop.earn_transactions.find(params.expect(:id))
  end

  def earn_transaction_params
    params.expect(earn_transaction: [:user_id, :purchase_amount, :points_earned, :transaction_ref])
  end
end
