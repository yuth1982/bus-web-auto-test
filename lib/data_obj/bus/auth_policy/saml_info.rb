module Bus
  module DataObj
    class SAMLInfo
      # Class for saml information
      attr_accessor :auth_channel, :auth_url, :saml_endpoint, :saml_cert, :encrypted

      def initialize(auth_channel, auth_url, saml_endpoint, saml_cert, encrypted)
        @auth_channel = auth_channel
        @auth_url = auth_url
        @saml_endpoint = saml_endpoint
        @saml_cert = saml_cert
        @encrypted = encrypted
      end
    end
  end
end