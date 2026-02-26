class UserPointsBalancesController < ApplicationController
  before_action :authenticate_mall_admin!
  before_action :set_user_points_balance, only: %i[show edit update]
  layout "dashboard"

  def index
    @user_points_balances = UserPointsBalance.all
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user_points_balance.update(user_points_balance_params)
        format.html { redirect_to @user_points_balance, notice: "User points balance was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @user_points_balance }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_points_balance.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user_points_balance
    @user_points_balance = UserPointsBalance.find(params.expect(:id))
  end

  def user_points_balance_params
    params.expect(user_points_balance: [:total_points, :lifetime_points])
  end
end
