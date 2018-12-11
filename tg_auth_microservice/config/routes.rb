Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/auth', controllers: {
    registrations:  'devise_overrides/registrations',
    passwords: 'devise_overrides/passwords',
    token_validations:  'devise_overrides/token_validations'
  }
  mount GrapeSwaggerRails::Engine, at: "/docs/"
  mount ApplicationApi => '/'
end
