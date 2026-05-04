class CategoriesController < ApplicationController
  before_action :authenticate_any_admin!
  load_and_authorize_resource
  layout "dashboard"

  def index
    @categories = @categories.where(mall_id: current_mall.id).order(:display_order) if current_mall
  end

  def show; end
  def new; end
  def edit; end

  def create
    @category.mall_id = current_mall.id if current_mall
    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: "Category was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: "Category was successfully updated.", status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy!
    redirect_to categories_path, notice: "Category was successfully destroyed.", status: :see_other
  end

  private

  def category_params
    params.expect(category: [:name, :description, :display_order, :icon_url])
  end
end
