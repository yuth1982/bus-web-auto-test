module Bus
  class MozyEnterprise < PartnerAccount
    attr_accessor :num_enterprise_users, :server_plan, :num_server_add_on
    def initialize
      super
      partner_info.type = Bus::COMPANY_TYPE[:mozyenterprise]
      @num_enterprise_users = true
      @server_plan = "None"
      @num_server_add_on = 0
    end

    def to_s
      "#{super}\nnum of enterprise users: #@num_enterprise_users\nserver plan: #@server_plan\nserver add-on: #@num_server_add_on"
    end
  end
end

