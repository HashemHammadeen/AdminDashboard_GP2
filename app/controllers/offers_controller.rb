class OffersController < ApplicationController
  before_action :authenticate_shop_admin!
  before_action :set_offer, only: %i[show edit update destroy]
  layout "dashboard"

  def index
    @offers = current_shop_admin.shop.offers.order(created_at: :desc)
  end

  def show
  end

  def new
    @offer = current_shop_admin.shop.offers.new
  end

  def edit
  end

  def create
    @offer = current_shop_admin.shop.offers.new(offer_params)

    respond_to do |format|
      if @offer.save
        format.html { redirect_to @offer, notice: "Offer was successfully created." }
        format.json { render :show, status: :created, location: @offer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @offer.update(offer_params)
        format.html { redirect_to @offer, notice: "Offer was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @offer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @offer.destroy!
    respond_to do |format|
      format.html { redirect_to offers_path, notice: "Offer was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_offer
    @offer = current_shop_admin.shop.offers.find(params.expect(:id))
  end

  def offer_params
    params.expect(offer: [:name, :description, :image_url, :reward_type, :reward_value, :start_date, :end_date, :active])
  end
end
