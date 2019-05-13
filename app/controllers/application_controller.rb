class ApplicationController < ActionController::Base

  helper_method :access_token

  def client_credentials_flow
    conn = Faraday.new
    response = conn.post 'https://api.hoopla.net/oauth2/token',
                         grant_type: 'client_credentials',
                         response_type: 'token',
                         client_id: 'aad6311c-d5bf-4048-b4a8-c187a231d037',
                         client_secret: 'abacf08f528a5931d490f3dffb708fca95c2d72f3a4f'

    JSON.parse(response.body)
  end

  def access_token
    if @auth_response.nil?
      @auth_response = client_credentials_flow
    end
    @auth_response['access_token']
  end

end
