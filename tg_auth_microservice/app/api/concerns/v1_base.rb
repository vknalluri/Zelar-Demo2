module V1Base
  extend ActiveSupport::Concern

  HEADERS_DOCS = {
    Authorization: {
      description: "User Authorization Token",
      required: true
    }
  }

  included do
    format :json
    prefix :api
    default_format :json
    formatter :json, 
        Grape::Formatter::ActiveModelSerializers

    version 'v1', using: :header, vendor: API_VENDOR

    rescue_from ActiveRecord::RecordNotFound do |e|
      render_error(RESPONSE_CODE[:not_found], I18n.t("errors.#{e.model.to_s.downcase}.not_found"))
    end

    rescue_from ApiException do |e|
      render_error(e.http_status, e.error.message, e.error.debug_info)
    end

    helpers do
      def logger
        Rails.logger
      end

      def render_error(code, message, debug_info = '')
        error!({meta: {code: code, message: message, debug_info: debug_info}}, code)
      end

      def render_success(json, extra_meta = {})
        {data: json, meta: {code: RESPONSE_CODE[:success], message: "success"}.merge(extra_meta)}
      end
    end
  end
end