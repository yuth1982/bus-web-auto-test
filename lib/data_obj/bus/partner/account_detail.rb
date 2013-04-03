module Bus
  module DataObj
    # This class contains attributes for admin information
    class AccountDetail
      attr_accessor :account_type, :sales_origin, :sales_channel

      # Public: Initialize a AccountDetail Object
      #
      def initialize
        @acct_type = "Internal Test"
        @sales_origin = ""
        @sales_channel = ""
      end

      # Public: Output AdminInfo object attributes
      #
      # Returns text
      def to_s
        %{account_type: #@acct_type
        sales origin: #@sales_origin
        sales channel: #@sales_channel}
      end
    end
  end
end