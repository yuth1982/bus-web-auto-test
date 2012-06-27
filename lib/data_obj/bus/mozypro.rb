module Bus
  class MozyPro < Partner
    attr_accessor :supp_plan, :has_server_plan

    def initialize
      super
      @supp_plan = ""
      @has_server_plan = false
    end

    def to_s
      "#{super}\nsupp plan: #{@supp_plan}\nhas server plan: #{@has_server_plan}"
    end
  end
end