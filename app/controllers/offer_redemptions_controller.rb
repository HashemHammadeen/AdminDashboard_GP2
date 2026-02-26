class OfferRedemptionsController < ApplicationController
  before_action :authenticate_shop_admin!
  before_action :set_offer_redemption, only: %i[show edit update destroy]
  layout "dashboard"

  def index
    @offer_redemptions = OfferRedemption.where(shop_id: current_shop_admin.shop.id).order(created_at: :desc)
  end

  def show
  end

  def edit
  end

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

  def destroy
    @offer_redemption.destroy!
    respond_to do |format|
      format.html { redirect_to offer_redemptions_path, notice: "Offer redemption was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_offer_redemption
    @offer_redemption = OfferRedemption.where(shop_id: current_shop_admin.shop.id).find(params.expect(:id))
  end

  def offer_redemption_params
    params.expect(offer_redemption: [:offer_id, :user_id, :receipt_id])
  end
end
