module Bus
  module DataObj
    # This class contains attributes for company information
    class CompanyInfo
      attr_accessor :name, :address, :city, :state_abbrev, :state, :country, :zip, :phone, :vat_num

      # Public: Initialize a CompanyInfo Object
      #
      def initialize
        @name = "#{Forgery::Name.company_name} #{Forgery::Name.industry} Company"
        @address= Forgery::Address.street_address
        @city = Forgery::Address.city
        @state_abbrev = Forgery::Address.state_abbrev
        @state = Forgery::Address.state
        @country = "United States"
        @zip = "12345" #Random.rand(10000..99999).to_s
        @phone = "1234567890" #Forgery::Address.phone
        @vat_num = ""
      end
    end
  end
end