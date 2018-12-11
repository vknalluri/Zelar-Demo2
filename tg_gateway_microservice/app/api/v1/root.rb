module V1
  class Root < Grape::API
    include AppConstant
    # Set CORS
    before do
      header['Access-Control-Allow-Credentials'] = true
      header['Access-Control-Allow-Origin'] = '*'
      header['Access-Control-Request-Method'] = 'POST, GET, PUT, DELETE, OPTIONS'
      header['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end

    mount V1::Auth
    mount V1::Paths
    mount V1::Requests
    mount V1::Versions
  end
end
