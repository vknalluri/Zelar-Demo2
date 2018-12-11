class ApiErrorHandler < Grape::Middleware::Base
  def call!(env)
    @env = env
    begin
      @app.call(@env)
    rescue Exception => e
      if %w(production staging).include?(Rails.env) && e.class != UserError
        #Area to configure mailer notification for any alerts for different microservices. @env, @app are made available which we can use
        #for clear information about environement & microservice, parameters e.t.c.
      end
      raise
    end
  end
end

