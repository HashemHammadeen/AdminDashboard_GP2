class OfferRedemptionsController < ApplicationController
  before_action :authenticate_any_admin!
  load_and_authorize_resource
  layout "dashboard"

  def index
    @offer_redemptions = @offer_redemptions.where(shop_id: current_shop.id).includes(:user, :offer).order(created_at: :desc) if current_shop
    @offer_redemptions = @offer_redemptions.includes(:user, :offer, :shop).order(created_at: :desc) if current_mall
  end

  def show; end
  def edit; end

  def update
    respond_to do |format|
      if @offer_redemption.update(offer_redemption_params)
        format.html { redirect_to @offer_redemption, notice: "Offer redemption updated.", status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @offer_redemption.destroy!
    redirect_to offer_redemptions_path, notice: "Offer redemption deleted.", status: :see_other
  end

  private

  def offer_redemption_params
    params.expect(offer_redemption: [:status])
  end
end
