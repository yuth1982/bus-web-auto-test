module Bus
  module DataObj
    # This class contains attributes for data shuttle order
    class DataShuttleOrder
      attr_accessor :adapter_type, :os, :quota, :assign_to, :from, :discount, :num_win_drivers, :num_mac_drivers, :is_ship

      # Public: Initialize a DataShuttleOrder Object
      #
      def initialize(adapter_type, os, quota, assign_to, from, discount, num_win_drivers, num_mac_drivers, is_ship)
        @adapter_type = adapter_type
        @os = os
        @quota = quota
        @assign_to = assign_to
        @from = from
        @discount = discount
        @num_win_drivers = num_win_drivers
        @num_mac_drivers = num_mac_drivers
        @is_ship = is_ship
      end
    end
  end
end