class OffersController < ApplicationController
  before_action :authenticate_any_admin!
  load_and_authorize_resource
  layout "dashboard"

  def index
    @offers = @offers.where(shop_id: current_shop.id).order(created_at: :desc) if current_shop
    if current_mall
      @offers = @offers.includes(:shop).order(created_at: :desc)
      @reactivation_requests = @offers.where(reactivation_requested: true)
    end
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
    allowed_params = offer_params.dup
    
    if current_shop
      if @offer.inactive_by_mall_admin
        # Shop admin cannot reactivate directly
        allowed_params.delete(:active) if allowed_params[:active] == "1" || allowed_params[:active] == "true" || allowed_params[:active] == true
      end
    elsif current_mall
      if allowed_params[:active] == "0" || allowed_params[:active] == "false" || allowed_params[:active] == false
        @offer.inactive_by_mall_admin = true
      elsif allowed_params[:active] == "1" || allowed_params[:active] == "true" || allowed_params[:active] == true
        @offer.inactive_by_mall_admin = false
        @offer.reactivation_requested = false
      end
    end

    respond_to do |format|
      if @offer.update(allowed_params)
        format.html { redirect_to @offer, notice: "Offer was successfully updated.", status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def request_reactivation
    if current_shop
      @offer.update(reactivation_requested: true)
      redirect_to offers_path, notice: "Reactivation request sent to Mall Admin."
    else
      redirect_to offers_path, alert: "Not authorized."
    end
  end

  def approve_reactivation
    if current_mall
      @offer.update(active: true, inactive_by_mall_admin: false, reactivation_requested: false)
      redirect_to request.referer || offers_path, notice: "Offer reactivation approved."
    else
      redirect_to offers_path, alert: "Not authorized."
    end
  end

  def deny_reactivation
    if current_mall
      @offer.update(reactivation_requested: false)
      redirect_to request.referer || offers_path, notice: "Offer reactivation denied."
    else
      redirect_to offers_path, alert: "Not authorized."
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
