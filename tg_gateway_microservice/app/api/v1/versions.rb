module V1
  class Versions < Grape::API
    resource :versions do
      
      desc "Capturing Front-end Deployment Version number"
      params do
        requires :app_name, type: String, desc: "Application name"
        requires :version_number, type: String, desc: "Deployment Version Number"
      end
      post do
        @app = DeployVersion.find_by_app_name(params[:app_name])
        if @app.blank?
          @app = DeployVersion.new(app_name: params[:app_name], version_number: params[:version_number])
          @app.save
        else
          @app.update_attribute("version_number", params[:version_number])
        end
        present @app
      end

      desc 'Get Version Number'
      params do  
        requires :app_name, type: String, desc: "Application name"
      end
      get do
        @app = DeployVersion.find_by_app_name(params[:app_name])
        if @app.blank? 
          return []
        else 
          present @app.version_number
        end
      end

    end
  end
end
