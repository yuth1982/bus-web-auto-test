module AriaApi
  class Service
    def self.actions
      api_version = AriaApi::Configuration.api_version
      url = "https://secure.future.stage.ariasystems.net/api/Advanced/wsdl/#{api_version}/complete-doc_literal_wrapped.wsdl"
      #client = Savon::Client.new url 
      client = Savon::Client.new url do |wsdl, http|
        http.auth.ssl.verify_mode = :none
      end
      @actions ||= client.wsdl.soap_actions
    end
  end
end
