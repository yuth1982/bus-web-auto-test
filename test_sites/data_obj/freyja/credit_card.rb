module Freyja
  module DataObj
    # This class contains attributes for credit card information
    class CreditCard
      attr_accessor :full_name, :number, :expire_month, :expire_year, :cvv

      # Public: Initialize a CreditCard Object
      #
      def initialize
        @full_name = Forgery::Name.full_name
        @number = Forgery::CreditCard.number(:type => 'Visa', :length => 16).to_s
        @expire_month = Forgery::Date.month(:numerical => true).to_s
        @expire_year = Forgery::Date.year(:future => true, :past => false, :min_delta => 1, :max_delta => 5).to_s
        @cvv = Random.new.rand(100..999).to_s
      end

      # Public: Output CreditCard object attributes
      #
      # Returns text
      def to_s
        %{credit card name: #@full_name
        credit card number: #@number
        credit card expire month: #@expire_month
        credit card expire year: #@expire_year
        credit card cvv: #@cvv}
      end
    end
  end
end
