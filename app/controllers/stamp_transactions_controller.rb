class StampTransactionsController < ApplicationController
  before_action :set_stamp_transaction, only: %i[ show edit update destroy ]

  # GET /stamp_transactions or /stamp_transactions.json
  def index
    @stamp_transactions = StampTransaction.all
  end

  # GET /stamp_transactions/1 or /stamp_transactions/1.json
  def show
  end

  # GET /stamp_transactions/new
  def new
    @stamp_transaction = StampTransaction.new
  end

  # GET /stamp_transactions/1/edit
  def edit
  end

  # POST /stamp_transactions or /stamp_transactions.json
  def create
    @stamp_transaction = StampTransaction.new(stamp_transaction_params)

    respond_to do |format|
      if @stamp_transaction.save
        format.html { redirect_to @stamp_transaction, notice: "Stamp transaction was successfully created." }
        format.json { render :show, status: :created, location: @stamp_transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stamp_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stamp_transactions/1 or /stamp_transactions/1.json
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

  # DELETE /stamp_transactions/1 or /stamp_transactions/1.json
  def destroy
    @stamp_transaction.destroy!

    respond_to do |format|
      format.html { redirect_to stamp_transactions_path, notice: "Stamp transaction was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stamp_transaction
      @stamp_transaction = StampTransaction.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def stamp_transaction_params
      params.expect(stamp_transaction: [ :user_id, :shop_id, :stamp_id, :transaction_type, :stamps_count, :receipt_id ])
    end
end
