class OfferRedemptionsController < ApplicationController
  before_action :set_offer_redemption, only: %i[ show edit update destroy ]

  # GET /offer_redemptions or /offer_redemptions.json
  def index
    @offer_redemptions = OfferRedemption.all
  end

  # GET /offer_redemptions/1 or /offer_redemptions/1.json
  def show
  end

  # GET /offer_redemptions/new
  def new
    @offer_redemption = OfferRedemption.new
  end

  # GET /offer_redemptions/1/edit
  def edit
  end

  # POST /offer_redemptions or /offer_redemptions.json
  def create
    @offer_redemption = OfferRedemption.new(offer_redemption_params)

    respond_to do |format|
      if @offer_redemption.save
        format.html { redirect_to @offer_redemption, notice: "Offer redemption was successfully created." }
        format.json { render :show, status: :created, location: @offer_redemption }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @offer_redemption.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offer_redemptions/1 or /offer_redemptions/1.json
  def update
    respond_to do |format|
      if @offer_redemption.update(offer_redemption_params)
        format.html { redirect_to @offer_redemption, notice: "Offer redemption was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @offer_redemption }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @offer_redemption.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offer_redemptions/1 or /offer_redemptions/1.json
  def destroy
    @offer_redemption.destroy!

    respond_to do |format|
      format.html { redirect_to offer_redemptions_path, notice: "Offer redemption was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer_redemption
      @offer_redemption = OfferRedemption.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def offer_redemption_params
      params.expect(offer_redemption: [ :user_id, :offer_id, :shop_id, :receipt_id ])
    end
end
