module Bus
  module DataObj
    class PartnerInfo
      attr_accessor :type, :parent, :coupon_code
      def initialize
        @type = Bus::COMPANY_TYPE[:business]
        @parent = Bus::MOZY_ROOT_PARTNER[:mozypro]
        @coupon_code = ""
      end
    end
  end
end