require 'grape-swagger'
require 'api_error_handler'
class API < Grape::API
  prefix 'api'
  version 'v1', using: :path
  content_type :json, 'application/json'
  content_type :txt, 'text/plain'
  content_type :binary, 'application/octet-stream'
  default_format :json
  use ApiErrorHandler

  mount API::V1::Root
  # mount API::V2::Root (next version)

  add_swagger_documentation(
    base_path: "/",
    api_version: 'v1',
    hide_documentation_path: true,
    hide_format: true,
    mount_path: 'swagger.json',
    info: {
      title: 'Gateway Microservice',
      description: 'A service allowing you to authorize calls to microservices'
    }
  )
end
