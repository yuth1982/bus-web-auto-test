module Bus
  class Reseller < Partner
    attr_accessor :reseller_type, :reseller_quota, :reseller_add_on_quota, :has_server_plan

    def initialize
      super
      @reseller_type = "Silver" # Silver, Gold, Platinum
      @reseller_quota = 1
      @reseller_add_on_quota = 0
      @has_server_plan = false
    end

    def to_s
      "#{super}\nreseller type: #{@reseller_type}\nreseller quota: #{@reseller_quota}\nreseller add-on quota: #{@reseller_add_on_quota}\nhas server plan: #{@has_server_plan}"
    end
  end
end