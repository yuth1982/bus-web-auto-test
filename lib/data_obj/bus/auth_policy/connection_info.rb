module Bus
  module DataObj
    class ConnectionInfo
      # Class for connection information
      attr_accessor :server_host, :protocol, :ssl_cert, :port,
                    :base_dn, :bind_user, :bind_password, :org_name
      attr_reader :current_status, :last_sync, :next_sync

      def initialize(server, protocol, cert, port, base_dn, bind_user, bind_password, org_name)
        @server_host = server
        @protocol = protocol
        @ssl_cert = cert
        @port = port
        @base_dn = base_dn
        @bind_user = bind_user
        @bind_password = bind_password
        @org_name = org_name
      end
    end
  end
end