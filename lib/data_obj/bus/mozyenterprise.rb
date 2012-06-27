module Bus
  class MozyEnterprise < Partner
    attr_accessor :num_enterprise_users, :supp_plan, :has_server_plan

    def initialize
      super
      @num_enterprise_users = true
      @supp_plan = ""
      @num_server_add_on = 0
    end

    def to_s
      "#{super}\nnum of enterprise users: #{@num_enterprise_users}\nsupp plan: #{@supp_plan}\nserver add-on: #{@num_server_add_on}"
    end
  end
end

