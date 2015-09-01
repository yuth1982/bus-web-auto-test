module Bus
  module DataObj
    # This class contains attributes for client configuration
    class ConfigPreferences
      attr_accessor :warning_days, :net_iftype, :ckey, :private_key, :all_settings
    end
  end
end
