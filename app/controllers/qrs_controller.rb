class QrsController < ApplicationController
  before_action :set_qr, only: %i[ show edit update destroy ]

  # GET /qrs or /qrs.json
  def index
    @qrs = Qr.all
  end

  # GET /qrs/1 or /qrs/1.json
  def show
  end

  # GET /qrs/new
  def new
    @qr = Qr.new
  end

  # GET /qrs/1/edit
  def edit
  end

  # POST /qrs or /qrs.json
  def create
    @qr = Qr.new(qr_params)

    respond_to do |format|
      if @qr.save
        format.html { redirect_to @qr, notice: "Qr was successfully created." }
        format.json { render :show, status: :created, location: @qr }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @qr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /qrs/1 or /qrs/1.json
  def update
    respond_to do |format|
      if @qr.update(qr_params)
        format.html { redirect_to @qr, notice: "Qr was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @qr }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @qr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qrs/1 or /qrs/1.json
  def destroy
    @qr.destroy!

    respond_to do |format|
      format.html { redirect_to qrs_path, notice: "Qr was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_qr
      @qr = Qr.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def qr_params
      params.expect(qr: [ :user_id, :shop_id, :qr_code_data, :expires_at ])
    end
end
