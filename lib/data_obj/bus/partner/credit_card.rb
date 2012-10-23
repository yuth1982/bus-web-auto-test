module Bus
  module DataObj
    # This class contains attributes for credit card information
    class CreditCard
      attr_accessor :first_name, :last_name, :number, :cvv, :expire_month, :expire_year, :last_four_digits

      # Public: Initialize a CreditCard Object
      #
      def initialize
        @first_name = Forgery::Name.first_name
        @last_name = Forgery::Name.last_name
        @number = Forgery::CreditCard.number(:type => 'Visa', :length => 16).to_s
        @cvv = Random.rand(100..999).to_s
        @expire_month = Forgery::Date.month(:numerical => true).to_s
        @expire_year = Forgery::Date.year(:future => true, :past => false, :min_delta => 1, :max_delta => 5).to_s
        @last_four_digits = @number[12..-1]
      end
    end
  end
end