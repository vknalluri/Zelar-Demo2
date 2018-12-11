class DeviseOverrides::TokenValidationsController < ApplicationController
  def validate_token
		# @resource will have been set by set_user_by_token concern
    @resource = User.find_by_email(params[:uid])
		if @resource
			render json: {
			success: true,
			data: @resource
			}
		else
			render json: {
			success: false,
			errors: ["Invalid login credentials"]
			}, status: 401
		end
	end
end
