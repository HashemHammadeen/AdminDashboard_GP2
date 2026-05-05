class MallsController < ApplicationController
  before_action :authenticate_any_admin!
  load_and_authorize_resource
  layout "dashboard"

  def index
    @malls = @malls.where(mall_id: current_mall.mall_id) if current_mall
  end

  def show; end
  def new; end
  def edit; end

  def create
    respond_to do |format|
      if @mall.save
        format.html { redirect_to @mall, notice: "Mall was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @mall.update(mall_params)
        format.html { redirect_to @mall, notice: "Mall was successfully updated.", status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @mall.destroy!
    redirect_to malls_path, notice: "Mall was successfully destroyed.", status: :see_other
  end

  private

  def mall_params
    params.expect(mall: [:name, :location, :logo_url, :cover_image_url])
  end
end
