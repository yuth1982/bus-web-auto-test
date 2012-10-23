module Bus
  module DataObj
    # This class contains attributes for mozy enterprise partner
    class MozyEnterprise < PartnerAccount
      attr_accessor :num_enterprise_users, :server_plan, :num_server_add_on

      # Public: Initialize a MozyEnterprise Object
      #
      def initialize
        super
        #partner_info.type = Bus::COMPANY_TYPE[:mozyenterprise]
        @num_enterprise_users = 0
        @server_plan = "None"
        @num_server_add_on = 0
      end

      # Public: output mozy enterprise partner attributes
      #
      # Returns mozy enterprise partner formatted attributes text
      def to_s
        "#{super}\nnum of enterprise users: #@num_enterprise_users\nserver plan: #@server_plan\nserver add-on: #@num_server_add_on"
      end
    end
  end
end

