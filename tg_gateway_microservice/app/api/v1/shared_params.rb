module V1
  module SharedParams
    extend Grape::API::Helpers
    include AppConstant

    # Convenience method for request-endpoint
    params :path_params do |_options|
      requires :service, type: String, values: @@service_list.keys, desc: "Name of the service requested"
      requires :path, type: String, desc: "Path to request on the service"
      optional(
        :string_params,
        type: String,
        desc: "Parameters to be passed to the requested service, as a string of values",
        documentation: {example: "limit=1&offest=0"}
      )
      optional :token, type: String, desc: "User token, for use in auth"
    end
  end
end
