module Bus
  module DataObj
    # This class contains attributes for billing detail report
    class BillingDetailReport < Report
      attr_accessor :frequency, :start_date, :is_active
      # Public: Initialize a BillingDetailReport Object
      #
      def initialize
        @frequency = "Daily"
        @start_date = Time.now.localtime("-06:00").strftime("%Y %B %-d")
        @is_active = true
      end
    end
  end
end