module V1
  module AuthHelpers
    include AppConstant

    # Returns only specifically allowed headers vars.
    def parsed_headers(headers)
      header_list = [
        "access-token",
        "client",
        "connection",
        "Connection",
        "Content-security-policy",
        "date",
        "Date",
        "Etag",
        "expiry",
        "Location",
        "Paypal-Debug-Id",
        "pragma",
        "p3p",
        "set-cookie",
        "Set-Cookie",
        "Status",
        "strict-transport-security",
        "Strict-Transport-Security",
        "token-type",
        "uid",
        "Uid",
        "vary",
        "Vary",
        "x-fb-debug",
        "x-frame-options",
        "X-Frame-Options",
        "x-xss-protection",
        "X-Xss-Protection",
        "x-content-type-options",
        "Access-Control-Request-Headers"
      ]
      hdrs = Hash[header_list.map {|hdr| [hdr, headers[hdr]] }]
      hdrs.compact
    end

  end
end
