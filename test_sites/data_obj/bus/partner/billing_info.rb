module Bus
  module DataObj
    # This class contains attributes for billing information
    class BillingInfo
      attr_accessor :address, :city, :state_abbrev, :state, :country, :zip, :email, :phone, :billing, :order_summary

      # Public: Initialize a BillingInfo Object
      #
      def initialize
        @address= Forgery::Address.street_address
        @city = Forgery::Address.city
        @state_abbrev = Forgery::Address.state_abbrev
        @state = Forgery::Address.state
        @country = "United States"
        @zip = Random.new.rand(10000..99999).to_s
        @email = create_admin_email(Forgery::Name.first_name,Forgery::Name.last_name)
        @phone = Forgery::Address.phone
        @billing = {:base_plan_price => nil,
                    :server_plan_price => nil,
                    :add_on_quantity => nil,
                    :add_on_price => nil,
                    :add_on => nil,
                    :discounts => nil,
                    :pre_all_subtotal => nil,
                    :pre_tax_subtotal => nil,
                    :taxes => nil,
                    :total => nil,
                    :order_summary => nil
                    }

      end

      # Public: Output BillingInfo object attributes
      #
      # Returns text
      def to_s
        %{address: #@address
        city: #@city
        state abbrev (for US & CA only): #@state_abbrev
        state: #@state
        country: #@country                                                 e
        zip: #@zip
        email: #@email
        phone: #@phone}
      end
    end
  end
end
