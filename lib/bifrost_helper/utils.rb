module BifrostHelper
  module Utils
    EXPIRE_TIME = 1800
    BASE_URL = 'http://bifrost01.qa5.mozyops.com/'
    AUTH_URL = 'auth/exchange'
    VERSION  = 'application/vnd.mozy.bifrost+json;v=1'
    LICENSE_URL = 'accounts/licenses'

    # Public: Add a user to the default group of the partner
    #
    # Example
    #  BifrostHelper::Utils.get_auth('sdfasfasfasfq343243t')
    #  #=> Admin NjhlZjRkMDY2YWNjZDlhODI1ZGY5NTRhMDg4NGMyMDhkNTEwM2VlN2Q5NzEwZGIyMjllYWIzNmRhMmNjOTM4Yw==
    #
    # Returns auth_token
    def get_auth(api_key)
      response = RestClient.get "#{BASE_URL}#{AUTH_URL}", {'Api-Key' => api_key, 'Accept' => VERSION}
      token = JSON.parse(response.body)["token"]
      authorization = 'Admin ' + token
    end

    # Public:Get a license key of the default group of the partner, if not, create one
    #
    # auth - authentication
    #
    # Example
    #  BifrostHelper::Utils.get_auth('Admin NjhlZjRkMDY2YWNjZDlhODI1ZGY5NTRhMDg4NGMyMDhkNTEw')
    #  #=> ENNFGFEW235235JKHF354FADFSF
    #
    # Returns license keystring
    def get_keystring(auth)
      query = 'status=free&license_type=Desktop'
      get_res = RestClient.get "#{BASE_URL}#{LICENSE_URL}?#{query}", {'Authorization' => auth, 'Accept' => VERSION}
      body = JSON.parse(get_res.body)
      if 200 == get_res.code and body['total'] > 0
        key_string = body['items'][0]['data']['keystring']
      else
        body = {'license_type' => 'Desktop', 'licenses' => 1, 'quote_desired' => 2}
        post_res = RestClient.post "#{BASE_URL}#{LICENSE_URL}", body.to_json, {'Content-Type' => 'application/json', 'Authorization' => auth, 'Accept' => VERSION}
        if 201 == post_res.code
            key_string = JSON.parse(post_res.body)['items'][0]['data']['keystring']
        else
          key_string = -1
        end
      key_string
      end
    end

    # Public:Check if the token is expired
    #
    # begin_time - the time the token is created
    #
    # Example
    #  BifrostHelper::Utils.get_auth('2012-09-10 17:00:49 +0800')
    #  #=> false
    #
    # Returns boolean
    def expired?(begin_time)
      Time.now - begin_time <= EXPIRE_TIME ? true : false
    end
  end
end