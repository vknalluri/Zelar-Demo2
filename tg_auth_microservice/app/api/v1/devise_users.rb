module V1
  class DeviseUsers < Grape::API
    
  VALID_PARAMS = %w{id name email password password_confirmation current_password default_check}
    
    helpers do
      def user_params
        params.select{|key,value| VALID_PARAMS.include?(key.to_s)}
      end
    end

    resource :devise_users do  
      desc 'All Users'
      get do
        User.all
      end
    
    end
  end
end