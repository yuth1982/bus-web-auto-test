module Bus
  module DataObj
    # This class contains attributes for partner account information
    class PartnerAccount
      attr_accessor :company_info, :partner_info, :admin_info, :account_detail, :use_company_info,
                    :subscription_period, :has_initial_purchase, :credit_card, :net_term_payment, :pre_sub_total,
                    :order_summary

      # Public: Initialize a PartnerAccount Object
      #
      def initialize
        @company_info = CompanyInfo.new
        @partner_info = PartnerInfo.new
        @admin_info = AdminInfo.new
        @account_detail = AccountDetail.new
        @use_company_info = true
        @subscription_period = 1
        @has_initial_purchase = true
        @credit_card = CreditCard.new
        @net_term_payment = false
        @pre_sub_total = ""
        @order_summary = []
      end

      # Public: Output partner account attributes
      #
      # Returns text
      def to_s
        %{
        #{@company_info.to_s}
        #{@partner_info.to_s}
        #{@admin_info.to_s}
        #{@acccount_detail.to_s}
        #{@credit_card.to_s}
        use company info: #@use_company_info
        subscription period: #@subscription_period
        has initial purchase: #@has_initial_purchase
        net term payment: #@net_term_payment}
      end
    end
  end
end