class StampsController < ApplicationController
  before_action :authenticate_shop_admin!
  before_action :set_stamp, only: %i[show edit update destroy]
  layout "dashboard"

  def index
    @stamps = current_shop_admin.shop.stamps.order(created_at: :desc)
  end

  def show
  end

  def new
    @stamp = current_shop_admin.shop.stamps.new
  end

  def edit
  end

  def create
    @stamp = current_shop_admin.shop.stamps.new(stamp_params)

    respond_to do |format|
      if @stamp.save
        format.html { redirect_to @stamp, notice: "Stamp card was successfully created." }
        format.json { render :show, status: :created, location: @stamp }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stamp.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @stamp.update(stamp_params)
        format.html { redirect_to @stamp, notice: "Stamp card was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @stamp }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stamp.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @stamp.destroy!
    respond_to do |format|
      format.html { redirect_to stamps_path, notice: "Stamp card was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_stamp
    @stamp = current_shop_admin.shop.stamps.find(params.expect(:id))
  end

  def stamp_params
    params.expect(stamp: [:name, :description, :image_url, :stamp_icon_url, :stamps_required, :reward_type, :start_date, :end_date, :active])
  end
end
