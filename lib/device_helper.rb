require 'net/https'
require 'base64'

module KeylessDeviceActivation

  # As a user,
  # I want to install a Mozy client in my device, and activate it with my credentials (username and password) and without a license key,
  # then I can enjoy the awesome Mozy services.

  module Authentication
    #The client should send the user credentials, username and password,
    #to Mozy Auth service to exchange an access token. This requires two API calls.
    class Client
      attr_accessor :username, :password, :license_key
      def initialize(username, password, partner_id, partner_name, device_type, machine_name = nil, codename = nil)
        @username = username
        @password = password
        @partner_id = partner_id
        @partner_name = partner_name
        @device_type = device_type
        @codename = codename
        @client_name = "BAC#{Time.now.strftime("%m%d%H%M%S")}"
        @client_id = "bac#{Time.now.strftime("%m%d%H%M%S")}"
        @client_secret = "bac#{Time.now.strftime("%m%d%H%M%S")}"
        @random_value = ""; 16.times{@random_value  << (65 + rand(25)).chr}
        @random_value = ""; 16.times{@random_value  << (65 + rand(25)).chr}
        @random_value = ""; 16.times{@random_value  << (65 + rand(25)).chr}
        @machine_hash = "machinehash"+@random_value
        @sid = "sid_hash"+@random_value
        @mac = "mac_hash"+@random_value
        @machine_alias = machine_name || "AUTOTEST"
        @codename = codename || "mozypro"
        @auth_code = {}
        @access_token = {}
        @license_key = ""
        enable_partner_to_sso(@partner_id, @partner_name)
        create_oauth_client
        sso_auth(@partner_id)
        sso_to_auth
        client_devices_activate
      end

      def enable_partner_to_sso(partner_id, partner_name)
        uri = URI.parse("http://#{BUS_ENV['sso_host']}")
        Net::HTTP.start(uri.host, uri.port,
                        :use_ssl => uri.scheme == 'https') do |http|
          partner_name = CGI::escape (partner_name)
          string = "/enabled_partners"\
          +"?pro_partner_id="+partner_id\
          +"&pro_partner_name="+partner_name
          request = Net::HTTP::Get.new( string )
          response = http.request request
          result = JSON.parse(response.body)
          result.each do |hash|
            if hash['pro_partner_id'] == partner_id.to_i
              Log.debug 'already added to the enabled partners list'
              return
            end
          end
          request = Net::HTTP::Post.new( string )
          http.request(request)
        end
      end

      def create_oauth_client
        uri = URI.parse("http://#{BUS_ENV['sso_host']}")
        Net::HTTP.start(uri.host, uri.port,
                        :use_ssl => uri.scheme == 'https') do |http|
          string = "/oauth/clients"\
          +"?name="+@client_name\
          +"&identifier="+@client_id\
          +"&secret="+@client_secret\
          +"&trusted=true"\
          +"&mobile_client=true"\
          +"&url="\
          +"&contact_name="\
          +"&contact_phone="\
          +"&contact_email="\
          +"&expiration_limit="\
          +"&permissions%5B%5D="\
          +"triton_manifest&permissions%5B%5D=triton_read"\
          +"&permissions%5B%5D=triton_write"\
          +"&permissions%5B%5D=mip_fs_read"\
          +"&permissions%5B%5D=mip_fs_write"\
          +"&permissions%5B%5D=mip_photos_read"\
          +"&permissions%5B%5D=mip_photos_write"

          request = Net::HTTP::Post.new( string )
          http.request(request)
        end
      end

      def sso_auth(partner_id)
        #Grant an authorization code
        #
        #Client send username and password to the /login/oauth/authorize API to get an authorization code
        #GET /login/oauth/authorize?client_id=5 HTTP/1.1
        #Host: auth01.qa6.mozyops.com
        #Authorization: Basic base64(username:password)
        #http://sso01.qa6.mozyops.com/#oauth/clients
        # =>{"code": 129383238042ABCDE23}

        uri = URI.parse("http://#{BUS_ENV['auth_host']}")

        Net::HTTP.start(uri.host, uri.port,
                        :use_ssl => uri.scheme == 'https') do |http|
          request = Net::HTTP::Get.new("/login/oauth/authorize?client_id=#{@client_id}")
          request.basic_auth(@username, @password)
          http.request request
        end

        # Exception for dup username is 409 Conflict
        # And then, the client should call the /login/oauth/authorize API again
        # with an additional parameter 'partner_id', to tell Auth which user in which partner it wants to authorize.
        # GET /login/oauth/authorize?client_id=5&partner_id=123 HTTP/1.1
        #Host: auth.mozy.com
        #Authorization: Basic base64(username:password)
        Net::HTTP.start(uri.host, uri.port,
                        :use_ssl => uri.scheme == 'https') do |http|
          request = Net::HTTP::Get.new("/login/oauth/authorize?client_id=#{@client_id}&partner_id=#{partner_id}")
          request.basic_auth(@username, @password)
          response = http.request request
          @auth_code = JSON.parse(response.body)
        end
      end

      def sso_to_auth
        #Exchange a SSO access token with the authorization code by calling the /login/oauth/access_token API.
        #POST /login/oauth/access_token HTTP/1.1
        #Host: auth.mozy.com
        #Authorization: Basic base64(client_id:client_secret)
        #
        #grant_type=authorization_code&code=<authorization_code>
        # =>{'access_token': 123454354354ABCDEF2134}
        uri = URI.parse("http://#{BUS_ENV['auth_host']}")
        Net::HTTP.start(uri.host, uri.port,
                        :use_ssl => uri.scheme == 'https') do |http|
          request = Net::HTTP::Post.new("/login/oauth/access_token?grant_type=authorization_code&code=#{@auth_code["code"]}")
          request.basic_auth(@client_id, @client_secret)
          response = http.request request
          @access_token = JSON.parse(response.body)
        end
      end

      def client_devices_activate
        #PUT /client/devices/6214ad3f5d3885c028a68b82000cf1a3a757/activate
        #Host: mozypro.com
        #Authorization: Bearer base64(<access_token>)
        #
        #alias=abc&mac_hash=xxxxxxxxxxxx&sid_hash=xxxxxxxxx&country=US&type=Desktop

        uri = URI.parse("#{BUS_ENV['bus_host']}")
        Net::HTTP.start(uri.host, uri.port,
                        :use_ssl => uri.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|
          url =  "/client/devices/#{@machine_hash}/activate?alias=#{@machine_alias}&mac_hash=#{@mac}&sid_hash=#{@sid}&country=US&type=#{@device_type}&codename=#{@codename}"
          request = Net::HTTP::Put.new( url )
          request.add_field("Authorization", "Bearer #{Base64.strict_encode64(@access_token["access_token"])}")
          response = http.request request
          @license_key = JSON.parse(response.body)
          Log.debug("license key = #{@license_key}")
          @license_key = @license_key["license_key"]
        end
      end
    end
  end
end
