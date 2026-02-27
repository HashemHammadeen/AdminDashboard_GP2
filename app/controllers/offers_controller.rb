class OffersController < ApplicationController
  before_action :authenticate_any_admin!
  load_and_authorize_resource
  layout "dashboard"

  def index
    @offers = @offers.where(shop_id: current_shop.id).order(created_at: :desc) if current_shop
    @offers = @offers.includes(:shop).order(created_at: :desc) if current_mall
  end

  def show; end
  def new; end
  def edit; end

  def create
    @offer.shop_id = current_shop.id if current_shop
    respond_to do |format|
      if @offer.save
        format.html { redirect_to @offer, notice: "Offer was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @offer.update(offer_params)
        format.html { redirect_to @offer, notice: "Offer was successfully updated.", status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @offer.destroy!
    redirect_to offers_path, notice: "Offer was successfully destroyed.", status: :see_other
  end

  private

  def offer_params
    params.expect(offer: [:name, :description, :image_url, :reward_type, :reward_value, :start_date, :end_date, :active])
  end
end
