class MetricValuesController < ApplicationController
  def index
    href = params.require('href')
    owner = params.require('owner')
    @metric_values = get_metric_values(access_token, href, owner)
    @metric_values
  end

  def edit
    href = params.require('href')
    @metric_value = get_metric_values(access_token, href)
  end

  def update
    @metric = JSON.parse(params.require('metric'))
    value = params.require('value')
    update_metric_value(access_token, @metric, value)
    redirect_to metric_values_index_url(href: @metric['href'], owner: @metric['metric']['href'])
  rescue StandardError => e
      flash[:error] = "Error: #{e.message}"
  end

  private

  def get_metric_values(access_token, href, owner = nil)
    conn = Faraday.new
    resp = conn.get do |req|
      req.url "#{href}" #"#{href}?owner.href=#{owner}"
      req.headers['Authorization'] = "Bearer " + access_token
    end
    JSON.parse(resp.body)
  end

  def update_metric_value(access_token, metric, value)
    payload = [{
        href: metric['href'],
        metric: {
            href: metric['metric']['href']
        },
        owner: {
            kind: metric['owner']['kind'],
            href: metric['owner']['href']
        },
        value: value
    }]

    conn = Faraday.new
    resp = conn.put do |req|
      req.url metric['href']
      req.headers['Authorization'] = "Bearer " + access_token
      req.headers['Content-Type'] = 'application/vnd.hoopla.metric-value+json'
      req.body = payload
    end
    JSON.parse(resp.body)
  end
end
