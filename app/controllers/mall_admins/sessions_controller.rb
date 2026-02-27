class MallAdmins::SessionsController < Devise::SessionsController
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = MallAdmin.find_by(email: params[:mall_admin][:email])
    
    # Block login entirely if the admin's mall does not match the subdomain's mall
    if user && @current_tenant_mall && user.mall != @current_tenant_mall
      flash.now[:alert] = "This admin account does not belong to #{@current_tenant_mall.mall_name}."
      self.resource = MallAdmin.new(email: params[:mall_admin][:email])
      return render :new, status: :unprocessable_entity
    end
    
    super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
end
