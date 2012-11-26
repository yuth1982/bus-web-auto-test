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
  # home specific items
  element(:add_storage_tb, id: "additional_storage")
  element(:add_machine_select, id: "extra_machine_count")
  element(:promo_cde_tb, id: "promo-code")
  element(:plan_summary_table, css: "table.summary")
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


  #
  #
  # generic plan fill out section
  # code applies to both home and pro
  #
  #
  def fill_base_plan(base_plan)
       find_field("#{base_plan}").click
    end

  def fill_subscription_period(partner)
      if partner.partner_info.type.eql?("MozyPro")
          find_by_id("interval_#{partner.subscription_period}").click
        else
          find_by_id("period_#{partner.subscription_period}").click
      end
  end

  # mozy pro specific bloc
  # vat entry
  #   check to see if we are in pro or home
  #   if pro, check country - for US do nothing
  #     for non-US, fill in vat number
  #     for US dom, non-US partner locale, we'll just have to set "partner.company_info.country" post dom selection
  #
  def vat_fill_out(partner)
    if partner.partner_info.type.eql?("MozyPro")
        if partner.company_info.country.eql?("United States")
        else
          vat_number_tb.type_text(partner.company_info.vat_num)
        end
      else
    end
  end

  def fill_out_server_add_on
      server_add_on_lbl.click
  end

  # mozy home specific bloc
  # plan summary section
  #   code to get headers and rows
  #   check for home or pro type, if home:
  #   call function, which asks for data + outputs it to console for use
  #
  #
  def plan_summary_table_headers
    plan_summary_table.headers_text
  end

  def plan_summary_table_rows
    plan_summary_table.rows_text
  end

  def get_plan_summary(partner)
    if partner.partner_info.type.eql?("MozyPro")
      # for pro, we do not show a summary on licensing page
      else
        # get plan summary from licensing page
        plan_summary_table_rows
        end
    end

  #
  #
  # generic plan fill out section
  # code applies to both home and pro
  #
  #
  def licensing_billing_fillout(partner)
      # define base plan
      fill_base_plan(partner.base_plan)
      # define base plan subscription period
      fill_subscription_period(partner)
      # vat number
      vat_fill_out(partner)
      # coupon code
        # stub : add in code for coupon later
      # server add-on
      if partner.has_server_plan.eql?(true)
        fill_out_server_add_on
        else
        end
      # get_plan_summary(partner)
      continue_btn.click
    end
  end
end