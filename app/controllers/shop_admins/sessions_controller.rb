class ShopAdmins::SessionsController < Devise::SessionsController
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = ShopAdmin.find_by(email: params[:shop_admin][:email])
    
    # Block login entirely if the shop admin's mall does not match the subdomain's mall
    if user && @current_tenant_mall && user.shop&.mall != @current_tenant_mall
      flash.now[:alert] = "This shop admin account does not belong to #{@current_tenant_mall.mall_name}."
      self.resource = ShopAdmin.new(email: params[:shop_admin][:email])
      return render :new, status: :unprocessable_entity
    end
    
    super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
end
