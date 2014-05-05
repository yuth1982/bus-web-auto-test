module Freyja
  module DataObj
    # This class contains attributes for data shuttle order
    class Restore
      attr_accessor :restore_name, :restore_type, :address_info, :credit_card

      # Public: Initialize the Restore object
      #
      def initialize
        @restore_name = "TestRestore-#{Time.now.strftime("%Y%m%d-%H%M%S")}"
        @restore_type = ""
        @address_info = AddressInfo.new
        @credit_card = CreditCard.new
      end

      # Public: output restore attributes
      #
      # Returns restore formatted attributes text
      def to_s
        %{
        #{@address_info.to_s}
        #{@credit_card.to_s}
        restore name: #@restore_name
        restore type: #@restore_type
        }
      end
    end
  end
end
