module Bus
  class PartnerAccount
    attr_accessor :company_info, :partner_info, :admin_info, :use_company_info,
                  :subscription_period, :has_initial_purchase, :credit_card, :net_term_payment
    def initialize
      @company_info = CompanyInfo.new
      @partner_info = PartnerInfo.new
      @admin_info = AdminInfo.new
      @use_company_info = true
      @subscription_period = 1
      @has_initial_purchase = true
      @credit_card = CreditCard.new
      @net_term_payment = false
    end

    def to_s
      "company: #{@company_info.name}\naddress: #{@company_info.address}\ncity: #{@company_info.city}\nstate: #{@company_info.state}\nstate abbrev: #{@company_info.state_abbrev}\ncountry: #{@company_info.country}\nzip: #{@company_info.zip}\nphone: #{@company_info.phone}\nvat_num: #{@company_info.vat_num}\ncompany type: #{partner_info.type}\ncreate under: #{@partner_info.parent}\ncoupon code: #{@partner_info.coupon_code}\nfull name: #{admin_info.full_name}\nemail: #{@admin_info.email}\nuse company info: #@use_company_info\nsubscription period: #@subscription_period\nhas initial purchase: #@has_initial_purchase\nnet term payment: #@net_term_payment\ncredit card name: #{@credit_card.name}\ncredit card number: #{@credit_card.number}\ncredit card cvv: #{@credit_card.cvv}\ncredit card expire month: #{@credit_card.expire_month}\ncredit card expire year: #{@credit_card.expire_year}"
    end
  end
end