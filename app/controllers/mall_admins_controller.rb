class MallAdminsController < ApplicationController
  before_action :authenticate_mall_admin!
  before_action :set_mall_admin, only: %i[show edit update destroy]
  layout "dashboard"

  def index
    @mall_admins = MallAdmin.includes(:mall).all
  end

  def show
  end

  def new
    @mall_admin = MallAdmin.new
  end

  def edit
  end

  def create
    @mall_admin = MallAdmin.new(mall_admin_params)

    respond_to do |format|
      if @mall_admin.save
        format.html { redirect_to @mall_admin, notice: "Mall admin was successfully created." }
        format.json { render :show, status: :created, location: @mall_admin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @mall_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @mall_admin.update(mall_admin_params)
        format.html { redirect_to @mall_admin, notice: "Mall admin was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @mall_admin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @mall_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @mall_admin.destroy!
    respond_to do |format|
      format.html { redirect_to mall_admins_path, notice: "Mall admin was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_mall_admin
    @mall_admin = MallAdmin.find(params.expect(:id))
  end

  def mall_admin_params
    params.expect(mall_admin: [:name, :email, :phone, :mall_id, :password, :password_confirmation])
  end
end
