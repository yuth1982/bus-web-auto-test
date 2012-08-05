module Bus
  module DataObj
    # This class contains attributes for data shuttle order
    class DataShuttleOrder
      attr_accessor :adapter_type, :os, :quota, :assign_to, :key_from, :discount, :num_win_drivers, :num_mac_drivers, :ship_driver

      # Public: Initialize a DataShuttleOrder Object
      #
      def initialize
        @adapter_type = "Data Shuttle US"
        @os = "Win"
        @quota = 0
        @assign_to = ""
        @key_from = "new"
        @discount = 0
        @num_win_drivers = 0
        @num_mac_drivers = 0
        @ship_driver = true
      end
    end
  end
end