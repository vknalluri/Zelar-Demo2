module V1
  # API to return frontend-accessible paths
  class Paths < Grape::API
    resource :paths do
      desc "List all paths"
      params do
        # No params for now
      end
      get do
        paths = [
          {
            path_regex: '\A/auth/sign_in/\z',
            method: 'POST',
            send_user_id: false,
            auth_user_only: false,
          },

          {
            path_regex: '\A/users/\d+\z',
            method: 'GET',
            send_user_id: true,
            auth_user_only: true,
          }
        ]

        present paths
      end
    end
  end
end

