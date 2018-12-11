class DeviseOverrides::PasswordsController < DeviseTokenAuth::PasswordsController
  private
  def password_resource_params
    params.permit(
      :email,
      :password,
      :password_confirmation,
      :current_password,
      :reset_password_token,
      :redirect_url,
      :config
    )
  end
end
