class SystemConfigsController < ApplicationController
  before_action :authenticate_any_admin!
  load_and_authorize_resource
  layout "dashboard"

  def index
    @system_configs = @system_configs.all
  end

  def show; end
  def edit; end

  def update
    respond_to do |format|
      if @system_config.update(system_config_params)
        format.html { redirect_to @system_config, notice: "System configuration updated.", status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def system_config_params
    params.expect(system_config: [:earn_points_per_currency, :min_redemption_threshold, :points_to_currency_ratio])
  end
end
