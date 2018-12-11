require "grape-swagger"

module V1
  class Base < Grape::API
    mount V1::DeviseUsers
    mount V1::Paths
  end
end