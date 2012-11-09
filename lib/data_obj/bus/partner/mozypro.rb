module Bus
  module DataObj
    # This class contains attributes for mozy pro partner
    class MozyPro < PartnerAccount
      attr_accessor :base_plan, :has_server_plan, :storage_add_on

      # Public: Initialize a MozyPro Object
      #
      def initialize
        super
        #partner_info.type = Bus::COMPANY_TYPE[:mozypro]
        @base_plan = ""
        @has_server_plan = false
        @storage_add_on = 0
      end

      # Public: output mozy pro partner attributes
      #
      # Returns mozy pro partner formatted attributes text
      def to_s
        "#{super}\nbase plan: #@base_plan\nhas server plan: #@has_server_plan\nstorage add on:#@storage_add_on"
      end
    end
  end
end