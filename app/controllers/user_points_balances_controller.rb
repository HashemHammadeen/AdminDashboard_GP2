class UserPointsBalancesController < ApplicationController
  before_action :set_user_points_balance, only: %i[ show edit update destroy ]

  # GET /user_points_balances or /user_points_balances.json
  def index
    @user_points_balances = UserPointsBalance.all
  end

  # GET /user_points_balances/1 or /user_points_balances/1.json
  def show
  end

  # GET /user_points_balances/new
  def new
    @user_points_balance = UserPointsBalance.new
  end

  # GET /user_points_balances/1/edit
  def edit
  end

  # POST /user_points_balances or /user_points_balances.json
  def create
    @user_points_balance = UserPointsBalance.new(user_points_balance_params)

    respond_to do |format|
      if @user_points_balance.save
        format.html { redirect_to @user_points_balance, notice: "User points balance was successfully created." }
        format.json { render :show, status: :created, location: @user_points_balance }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_points_balance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_points_balances/1 or /user_points_balances/1.json
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

  # DELETE /user_points_balances/1 or /user_points_balances/1.json
  def destroy
    @user_points_balance.destroy!

    respond_to do |format|
      format.html { redirect_to user_points_balances_path, notice: "User points balance was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_points_balance
      @user_points_balance = UserPointsBalance.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def user_points_balance_params
      params.expect(user_points_balance: [ :user_id, :total_points, :lifetime_points ])
    end
end
