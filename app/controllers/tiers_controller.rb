class TiersController < ApplicationController
  before_action :authenticate_mall_admin!
  before_action :set_tier, only: %i[show edit update destroy]
  layout "dashboard"

  def index
    @tiers = Tier.order(:points_required).all
  end

  def show
  end

  def new
    @tier = Tier.new
  end

  def edit
  end

  def create
    @tier = Tier.new(tier_params)

    respond_to do |format|
      if @tier.save
        format.html { redirect_to @tier, notice: "Tier was successfully created." }
        format.json { render :show, status: :created, location: @tier }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tier.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tier.update(tier_params)
        format.html { redirect_to @tier, notice: "Tier was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @tier }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tier.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tier.destroy!
    respond_to do |format|
      format.html { redirect_to tiers_path, notice: "Tier was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_tier
    @tier = Tier.find(params.expect(:id))
  end

  def tier_params
    params.expect(tier: [:tier_name, :points_required, :color_hex, :icon_url, :benefits])
  end
end
