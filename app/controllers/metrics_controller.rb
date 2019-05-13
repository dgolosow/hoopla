class MetricsController < ApplicationController
  def index
    @metrics = get_metrics(access_token)
  end

  def get_metrics(access_token)
    conn = Faraday.new
    resp = conn.get do |req|
      req.url 'https://api.hoopla.net/metrics'
      req.headers['Authorization'] = "Bearer " + access_token
    end
    JSON.parse(resp.body)
  end
end
