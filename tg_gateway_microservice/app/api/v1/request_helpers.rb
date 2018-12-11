module V1
  module RequestHelpers
    include AppConstant
    
    def call_service(method, service, path, string_params, add_token_headers=false, token_hash=nil)
      base_url = @@service_list[service] rescue ""
      token = auth_token
      token = token_hash if token_hash.present?
      headers = {}
      unless service_paths(service)
        # Get the allowed paths
        paths_response = http.get base_url + "/paths"
        raise "Cannot contact downstream service" unless success_from_code(paths_response.try(:code)) # Error if status != 2XX
        # Check if the path is allowed
        set_service_paths(service, JSON.parse(paths_response.body))
      end
      valid_path = validated_path(service_paths(service), path, method)
      raise UserError, "Security Error" unless valid_path
      path_requires = path_requires(valid_path) # Extract path params
      auth_data = auth_data(token)
      auth_user_only_check(auth_data) if path_requires[:auth_user_only]    
      process_request(method, base_url + path, string_params, headers)
    end

    # Raises error if user is not logged in.
    def auth_user_only_check(auth_data)
      raise UserError, "You must be logged in to access this path" unless auth_data[:user_id]
    end

    # Gets data from auth. Validates token if present.
    def auth_data(token)
      access_token = token["access-token"] || token["Access-Token"] rescue nil
      uid = token["uid"] || token["Uid"] rescue nil
      client = token["client"] || token["Client"] rescue nil
      data = { user_id: nil }
      return data unless token.present? && uid.present? && access_token.present?
      auth_response = parsed_content(validate_token(uid, access_token, client))
      return data unless auth_response && auth_response['data'].present?
      auth_response_data = auth_response['data']
      data[:user_id] = auth_response_data['id'] if auth_response_data['id'].present?
      data
    end

    # Returns any requirements for the path.
    def path_requires(path)
      {
        auth_user_only: path["auth_user_only"] || false,
        send_user_id: path["send_user_id"] || false
      }
    end

    # Makes the http request.
    def process_request(method, url, string_params, headers)
      case method
      when "GET"
        response = http.get url.gsub('%','%25'), string_params, headers
      when "POST"
        response = http.post url, string_params, headers
      when "PUT"
        response = http.put url, string_params, headers
      when "DELETE"
        response = http.delete url, string_params, headers
      else
        raise UserError, "Security Error"
      end
      response
    end

    # Get the allowed paths for a service. Returns the allowed_path if found. Returns Nil otherwise.
    def validated_path(allowed_paths, path, method)
      selected_path = nil
      allowed_paths.each do |allowed_path|
        if Regexp.new(allowed_path["path_regex"]).match(path) && allowed_path["method"] == method
          selected_path = allowed_path
          break
        end
      end
      selected_path
    end

    # Returns included headers for token.
    def included_headers
      {
        "uid"                       => "Uid",
        "access-token"              => "Access-Token",
        "token-type"                => "Token-Type",
        "expiry"                    => "Expiry",
        "client"                    => "Client",
        "User-Agent"                => "User-Agent",
        "Upgrade-Insecure-Requests" => "Upgrade-Insecure-Requests"
      }
    end

    # Get the auth token from the headers. Return as a hash.
    def auth_token
      Hash[included_headers.map{|key,value| [key, headers[value]]}]
    end


    # Return the token via grape-api. Uses grape-api's 'header' method to present the token headers.
    def present_token(token_headers)
      included_headers.each do |name, _val|
        header[name] = token_headers[name]
      end
    end

    # Parses JSON from the response.
    def parsed_content(response)
      JSON.parse(response.content) rescue response.content
    end

    # Separates and sanitizes the params.
    def parsed_params(params)
      string_params = params["string_params"]
      other_params = params.except(:service, :path, :token, :string_params).to_query
      all_params = string_params ? string_params + "&" + other_params : other_params
      sanitize_params(all_params) # Remove user_id if they were passed
    end

    # Validate the token with auth.
    def validate_token(uid, access_token, client=nil)
      params = "uid=#{CGI.escape(uid)}&access-token=#{access_token}"
      params += "&client=#{client}" if client
      auth_path = @@service_list['auth_local'] + '/auth/validate_token'
      response = process_request('GET', auth_path, params, {})
      present_token(response.headers)
      response
    end

    # Returns http instance. Creates one if necessary.
    def http
      @http ||= create_http
    end

    # Creates an http instance.
    def create_http
      http = CttHttpClient.new
      http.ssl_config.verify_mode = OpenSSL::SSL::VERIFY_NONE if Rails.env.production?
      http
    end

    protected

    # Removes user_id and is_admin if they were passed.
    def sanitize_params(string_params)
      if /user_id/.match(string_params)
        hash_params = Rack::Utils.parse_nested_query(string_params).with_indifferent_access
        hash_params.delete(:user_id)
        string_params = hash_params.to_query
      end
      string_params
    end

    # Determines whether an http call was successful from its status code.
    def success_from_code(code)
      code / 100 == 2
    end

    def service_paths(service)
      AppConstant.service_paths[service]
    end

    def set_service_paths(service, paths)
      AppConstant.service_paths[service] = paths
    end
  end
end
