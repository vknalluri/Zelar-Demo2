module V1
  class Requests < Grape::API
    helpers RequestHelpers
    helpers AuthHelpers
    helpers SharedParams

    resource :requests do
      desc "Make a GET request"
      params do
        use :path_params
      end
      get do
        response = call_service('GET', params[:service], params[:path], parsed_params(params))
        status response.status
        present parsed_content(response)
      end

      desc "Make a PUT request"
      params do
        use :path_params
      end
      put do
        response = call_service('PUT', params[:service], params[:path], parsed_params(params))
        status response.status
        present parsed_content(response)
      end

      desc "Make a POST request"
      params do
        use :path_params
        optional :attachment, type: File, desc: "A file to be forwarded"
      end
      post do
        response = call_service(
          'POST',
          params[:service],
          params[:path],
          parsed_params(params),
          false,
          params[:attachment]
        )
        status response.status
        present parsed_content(response)
      end

      desc "Make a DELETE request"
      params do
        use :path_params
      end
      delete do
        response = call_service('DELETE', params[:service], params[:path], parsed_params(params))
        status response.status
        present parsed_content(response)
      end
    end
  end
end
