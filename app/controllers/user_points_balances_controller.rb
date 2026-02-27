class UserPointsBalancesController < ApplicationController
  before_action :authenticate_any_admin!
  load_and_authorize_resource
  layout "dashboard"

  def index
    @user_points_balances = @user_points_balances.includes(:user).order(total_points: :desc)
  end

  def show; end
  def edit; end

  def update
    respond_to do |format|
      if @user_points_balance.update(user_points_balance_params)
        format.html { redirect_to @user_points_balance, notice: "Points balance updated.", status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_points_balance_params
    params.expect(user_points_balance: [:total_points, :lifetime_points])
  end
end
