class MallsController < ApplicationController
  before_action :authenticate_mall_admin!
  before_action :set_mall, only: %i[show edit update destroy]
  layout "dashboard"

  def index
    @malls = Mall.all
  end

  def show
  end

  def new
    @mall = Mall.new
  end

  def edit
  end

  def create
    @mall = Mall.new(mall_params)

    respond_to do |format|
      if @mall.save
        format.html { redirect_to @mall, notice: "Mall was successfully created." }
        format.json { render :show, status: :created, location: @mall }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @mall.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @mall.update(mall_params)
        format.html { redirect_to @mall, notice: "Mall was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @mall }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @mall.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @mall.destroy!
    respond_to do |format|
      format.html { redirect_to malls_path, notice: "Mall was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_mall
    @mall = Mall.find(params.expect(:id))
  end

  def mall_params
    params.expect(mall: [:mall_name, :location, :logo_url, :cover_image_url])
  end
end
