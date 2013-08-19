# Testlink API
# API docs for testlink 1.9.3 can be found http://jetmore.org/john/misc/phpdoc-testlink193-api/TestlinkAPI/TestlinkXMLRPCServer.html

require 'xmlrpc/client'

module TestlinkHelper
  class TestlinkAPIClient
    SERVER_URL = "http://10.135.8.18/testlink/lib/api/xmlrpc.php"
    API_KEY = "997f1d69d1300b66b914480651cf095d"
    def initialize(dev_key = API_KEY)
      @server = XMLRPC::Client.new2(SERVER_URL)
      @devKey = dev_key
    end

    def run_api(api, args)
      args['devKey'] ||= @devKey
      @server.call("tl.#{api}", args)
    end
  end
end