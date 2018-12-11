module V1
  class Auth < Grape::API
    helpers RequestHelpers
    helpers AuthHelpers

    resource :auth do
      desc "Validate token on auth"
      params do
        optional :token, type: String, desc: "User token, for use in auth"
      end
      get "/validate_token" do
        headers["Uid"] = '' if headers["Uid"].nil?
        response = validate_token(headers["Uid"], headers["Access-Token"], headers["Client"])
        Rails.logger.info "#{response.headers.inspect}"
        parsed_hdrs = parsed_headers(response.headers)
        parsed_hdrs.each do |hdr, value|
          header hdr, value
        end
        status response.status
        present parsed_content(response)
      end      

      desc "Create User"
      params do
        requires :email,                 type: String, desc: "User's email"
        requires :password,              type: String, desc: "User's password"
        requires :password_confirmation, type: String, desc: "User's password again"
      end
      post "/" do
        response = call_service("POST", "auth_local", "/auth/", params.to_query)
        parsed_hdrs = parsed_headers(response.headers)
        parsed_hdrs.each do |hdr, value|
          header hdr, value
        end
        status response.status
        present parsed_content(response)
      end
      
    end
  end
end
