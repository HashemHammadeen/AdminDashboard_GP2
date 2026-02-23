class RedeemTransactionsController < ApplicationController
  before_action :set_redeem_transaction, only: %i[ show edit update destroy ]

  # GET /redeem_transactions or /redeem_transactions.json
  def index
    @redeem_transactions = RedeemTransaction.all
  end

  # GET /redeem_transactions/1 or /redeem_transactions/1.json
  def show
  end

  # GET /redeem_transactions/new
  def new
    @redeem_transaction = RedeemTransaction.new
  end

  # GET /redeem_transactions/1/edit
  def edit
  end

  # POST /redeem_transactions or /redeem_transactions.json
  def create
    @redeem_transaction = RedeemTransaction.new(redeem_transaction_params)

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

  # PATCH/PUT /redeem_transactions/1 or /redeem_transactions/1.json
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

  # DELETE /redeem_transactions/1 or /redeem_transactions/1.json
  def destroy
    @redeem_transaction.destroy!

    respond_to do |format|
      format.html { redirect_to redeem_transactions_path, notice: "Redeem transaction was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_redeem_transaction
      @redeem_transaction = RedeemTransaction.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def redeem_transaction_params
      params.expect(redeem_transaction: [ :user_id, :shop_id, :points_used, :discount_value, :verification_code, :status, :completed_at ])
    end
end
