class CttHttpClient < HTTPClient

  def get(*args)
    super(*args)
  rescue HTTPClient::ReceiveTimeoutError => e
    super(*args)
  end

  def put(*args)
    super(*args)
  rescue HTTPClient::ReceiveTimeoutError => e
    super(*args)
  end

  def post(*args)
    super(*args)
  rescue HTTPClient::ReceiveTimeoutError => e
    super(*args)
  end

  def delete(*args)
    super(*args)
  rescue HTTPClient::ReceiveTimeoutError => e
    super(*args)
  end

end