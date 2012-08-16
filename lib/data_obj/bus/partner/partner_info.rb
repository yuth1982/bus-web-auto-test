module Bus
  module DataObj
    # This class contains attributes for partner information
    class PartnerInfo
      attr_accessor :type, :parent, :coupon_code
      # Public: Initialize a AdminInfo Object
            #
      def initialize
        @type = Bus::COMPANY_TYPE[:business]
        @parent = Bus::MOZY_ROOT_PARTNER[:mozypro]
        @coupon_code = ""
      end
    end
  end
end