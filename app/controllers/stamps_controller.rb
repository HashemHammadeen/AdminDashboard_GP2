class StampsController < ApplicationController
  before_action :authenticate_any_admin!
  load_and_authorize_resource
  layout "dashboard"

  def index
    @stamps = @stamps.where(shop_id: current_shop.id).order(created_at: :desc) if current_shop
    @stamps = @stamps.includes(:shop).order(created_at: :desc) if current_mall
  end

  def show; end
  def new; end
  def edit; end

  def create
    @stamp.shop_id = current_shop.id if current_shop
    respond_to do |format|
      if @stamp.save
        format.html { redirect_to @stamp, notice: "Stamp program was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @stamp.update(stamp_params)
        format.html { redirect_to @stamp, notice: "Stamp program was successfully updated.", status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @stamp.destroy!
    redirect_to stamps_path, notice: "Stamp program was successfully destroyed.", status: :see_other
  end

  private

  def stamp_params
    params.expect(stamp: [:name, :description, :stamps_required, :reward_type, :image_url, :stamp_icon_url, :is_active, :start_date, :end_date])
  end
end
