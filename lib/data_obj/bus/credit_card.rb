module Bus
  class CreditCard
    attr_accessor :name, :number, :cvv, :expire_month, :expire_year
    def initialize
      @name = Forgery::Name.full_name
      @number = Forgery::CreditCard.number(:type => 'Visa', :length => 16).to_s #"4111111111111111"
      @cvv = Random.rand(100..999).to_s
      @expire_month = Forgery::Date.month(:numerical => true).to_s
      @expire_year = Forgery::Date.year(:future => true, :past => false, :min_delta => 1, :max_delta => 5).to_s
    end
  end
end