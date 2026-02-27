class TiersController < ApplicationController
  before_action :authenticate_any_admin!
  load_and_authorize_resource
  layout "dashboard"

  def index
    @tiers = @tiers.order(:points_required)
  end

  def show; end
  def new; end
  def edit; end

  def create
    respond_to do |format|
      if @tier.save
        format.html { redirect_to @tier, notice: "Tier was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tier.update(tier_params)
        format.html { redirect_to @tier, notice: "Tier was successfully updated.", status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tier.destroy!
    redirect_to tiers_path, notice: "Tier was successfully destroyed.", status: :see_other
  end

  private

  def tier_params
    params.expect(tier: [:tier_name, :points_required, :color_hex, :icon_url, :benefits])
  end
end
