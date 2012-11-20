module Phoenix
  class NewPartnerLicensingFillout < SiteHelper::Page

  set_url("#{PHX_ENV['phx_host']}")

  # Private elements
  #
  # Licensing Page Info
  #
  element(:base_plan_radio, id: "base_product_")
  element(:billing_period_radio, id: "interval_")
	element(:server_add_on_lbl, css: "label.add_on_name")
  element(:server_add_on_cb, id: :"add_id_")
  element(:vat_number_tb, id: "vat_num")
  element(:coupon_code_tb, id: "promo_code")
  #
  # Various elements
  #
  element(:next_btn, id: "next-button")
  element(:continue_btn, css: "input.img-button")
  element(:back_btn, id: "back_button")
  element(:submit_btn, id: "submit_button")
  # Public
  #
  # Licensing Page Fillout
  #
  # Code stub
  #
  def fill_base_plan(base_plan)
       find_field("#{base_plan}").click
    end

  def fill_subscription_period(period)
      find_by_id("interval_#{period}").click
    end

  def fill_out_server_add_on
      server_add_on_lbl.click
  end

  def licensing_billing_fillout(partner)
      # define base plan
      fill_base_plan(partner.base_plan)
      # define base plan subscription period
      fill_subscription_period(partner.subscription_period)
      # vat number
      if partner.company_info.country.eql?("United States")
        else
          vat_number_tb.type_text(partner.company_info.vat_num)
        end
      # coupon code
        # stub : add in code for coupon later
      # server add-on
      if partner.has_server_plan.eql?(true)
        fill_out_server_add_on
        else
        end
      continue_btn.click
    end
  end
end