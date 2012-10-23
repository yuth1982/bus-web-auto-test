module Bus
  module DataObj
    # This class contains attributes for partner information
    class PartnerInfo
      attr_accessor :type, :parent, :coupon_code
      # Public: Initialize a AdminInfo Object
            #
      def initialize
        @type = ""
        @parent = ""
        @coupon_code = ""
      end
    end
  end
end