module Bus
  module DataObj
    # This class contains attributes for client configuration
    class ClientConfig
      attr_accessor :name, :type, :throttle, :throttle_amount
      def initialize
        @name = ""
        @type = ""
        @throttle = false
        @throttle_amount = 0
      end
    end
  end
end
