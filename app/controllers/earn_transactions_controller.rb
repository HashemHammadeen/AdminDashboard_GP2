class EarnTransactionsController < ApplicationController
  before_action :set_earn_transaction, only: %i[ show edit update destroy ]

  # GET /earn_transactions or /earn_transactions.json
  def index
    @earn_transactions = EarnTransaction.all
  end

  # GET /earn_transactions/1 or /earn_transactions/1.json
  def show
  end

  # GET /earn_transactions/new
  def new
    @earn_transaction = EarnTransaction.new
  end

  # GET /earn_transactions/1/edit
  def edit
  end

  # POST /earn_transactions or /earn_transactions.json
  def create
    @earn_transaction = EarnTransaction.new(earn_transaction_params)

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

  # PATCH/PUT /earn_transactions/1 or /earn_transactions/1.json
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

  # DELETE /earn_transactions/1 or /earn_transactions/1.json
  def destroy
    @earn_transaction.destroy!

    respond_to do |format|
      format.html { redirect_to earn_transactions_path, notice: "Earn transaction was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_earn_transaction
      @earn_transaction = EarnTransaction.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def earn_transaction_params
      params.expect(earn_transaction: [ :user_id, :shop_id, :purchase_amount, :points_earned, :transaction_ref ])
    end
end
