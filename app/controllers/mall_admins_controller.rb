class MallAdminsController < ApplicationController
  before_action :authenticate_any_admin!
  load_and_authorize_resource
  layout "dashboard"

  def index
    @mall_admins = @mall_admins.where(mall_id: current_mall.id) if current_mall
  end

  def show; end
  def new; end
  def edit; end

  def create
    @mall_admin.mall_id = current_mall.id if current_mall
    respond_to do |format|
      if @mall_admin.save
        format.html { redirect_to @mall_admin, notice: "Mall admin was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @mall_admin.update(mall_admin_params)
        format.html { redirect_to @mall_admin, notice: "Mall admin was successfully updated.", status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @mall_admin.destroy!
    redirect_to mall_admins_path, notice: "Mall admin was successfully removed.", status: :see_other
  end

  private

  def mall_admin_params
    params.expect(mall_admin: [:name, :email, :phone, :password, :password_confirmation, :mall_id])
  end
end
