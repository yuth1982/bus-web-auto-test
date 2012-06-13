module Bus
  class Promotion
    attr_accessor :description, :promo_code, :discount_type, :discount_value, :valid_from, :valid_to, :usage_limit,
                  :valid_on_renewal

    def initialize
      @promo_code = Forgery::Basic.password(:at_least => 18, :at_most=>20)
      @description = @promo_code
      @discount_type = "Price Discount" #Price Discount | Percent Off
      @discount_value = 10
      @valid_from = Date.today.to_s
      @valid_to = (Date.today + 7).to_s
      @usage_limit = rand(1..10).to_s
      @valid_on_renewal = false
    end
  end
end