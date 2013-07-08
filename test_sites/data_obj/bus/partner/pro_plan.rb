module Bus
  module DataObj
    # This class contains attributes for data shuttle order
    class ProPlan
      attr_accessor :name, :comp_type, :root_role, :desc, :enabled, :public, :currency, :period, :tax, :price_per_gb, :min_gb
      def initialize(comp_type, name, price_per_gb = 0.05, min_gb = 1)
        @name = name || "$AUTOTEST$ #{Forgery(:basic).password(:at_least => 4, :at_most => 6)} Pro Plan"
        @comp_type = comp_type || "business"
        @price_per_gb = price_per_gb
        @min_gb = min_gb
      end
    end
  end
end
