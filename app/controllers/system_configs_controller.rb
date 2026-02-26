class SystemConfigsController < ApplicationController
  before_action :authenticate_mall_admin!
  before_action :set_system_config, only: %i[show edit update]
  layout "dashboard"

  def index
    @system_configs = SystemConfig.all
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @system_config.update(system_config_params)
        format.html { redirect_to @system_config, notice: "System config was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @system_config }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @system_config.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_system_config
    @system_config = SystemConfig.find(params.expect(:id))
  end

  def system_config_params
    params.expect(system_config: [:earn_points_per_currency, :min_redemption_threshold, :points_to_currency_ratio])
  end
end
