# encoding: utf-8
module Bus
  # This class provides actions for add new pro plan section
  class AddNewProPlanSection < SiteHelper::Section
    element(:plan_name_tb, id: "plan_name")
    element(:plan_company_type_select, css: "select[name='plan[company_type]']")
    element(:root_role_select, css: "select[name='plan[default_root_role_id]']")
    element(:description_textarea, id: 'plan_description')
    element(:enabled_select, id: 'plan_active')
    element(:public_select, id: 'plan_public')
    element(:currency_select, id: 'plan_currency_id')
    element(:biennial_checkbox, id: 'period_2')
    element(:yearly_checkbox, id: 'period_Y')
    element(:monthly_checkbox, id: 'period_M')
    element(:tax_percentage_input, css: "input[name='plan[tax]']")
    element(:tax_name_input, css: "input[name='plan[tax_name]']")
    element(:auto_include_tax_checkbox, id: 'plan_auto_include_tax')
    element(:server_tab, xpath: "//div[@id='plan-pro_new-tabs']//li[text()='Server']")
    element(:desktop_tab, xpath: "//div[@id='plan-pro_new-tabs']//li[text()='Desktop']")
    element(:price_per_key_input, css: 'input[id$=license_price]')
    element(:min_keys_input, css: 'input[id$=minimum_licenses]')
    element(:price_per_gigabyte_input, css: 'input[id$=quota_price]')
    element(:min_gigabytes_input, css: 'input[id$=minimum_quota]')
    element(:quota_price_tb, id: "price0_quota_price")
    element(:minimum_quota_tb, id: "price0_minimum_quota")
    element(:submit_btn, xpath: "//input[contains(@value, 'Save Changes')]")
    element(:anpp_message_li, css: "ul.flash.successes > li")

    # Public: Add a new pro plan
    #
    # @param [Object] pro_plan
    #
    # Example
    #   @bus_admin_console_page.add_new_role_section.add_new_pro_plan(Bus::DataObj::ProPlan:0x3a66668)
    #
    # @return [] nothing
    def add_new_pro_plan(pro_plan)
      plan_company_type_select.select(pro_plan.company_type)
      plan_name_tb.type_text(pro_plan.name)
      root_role_select.select(pro_plan.root_role)
      description_textarea.type_text(pro_plan.description)
      enabled_select.select(pro_plan.enabled)
      public_select.select(pro_plan.public)
      currency_select.select(pro_plan.currency)
      self.send("#{pro_plan.periods}_checkbox").check
      tax_percentage_input.type_text(pro_plan.tax_percentage)
      tax_name_input.type_text(pro_plan.tax_name)
      auto_include_tax_checkbox.check if pro_plan.auto_include_tax == 'yes'
      # pricing by key type input
      %w(server desktop).each do |type|
        if pro_plan.instance_variable_defined?("@#{type}")
          self.send("#{type}_tab").click
          price_per_key_input.type_text(pro_plan.send(type)[:price_per_key])
          min_keys_input.type_text(pro_plan.send(type)[:min_keys])
          price_per_gigabyte_input.type_text(pro_plan.send(type)[:price_per_gigabyte])
          min_gigabytes_input.type_text(pro_plan.send(type)[:min_gigabytes])
        end
      end
      if pro_plan.instance_variable_defined?('@generic')
        price_per_gigabyte_input.type_text(pro_plan.generic[:price_per_gigabyte])
        min_gigabytes_input.type_text(pro_plan.generic[:min_gigabytes])
      end
      #quota_price_tb.type_text(pro_plan.price_per_gb.to_s)
      #minimum_quota_tb.type_text(pro_plan.min_gb.to_s)

      submit_btn.click
    end

    # Public: Return messages
    #
    # @params [] none
    #
    # Example:
    #   @bus_site.admin_console_page.add_new_pro_plan_section.anpp_messages
    #
    # @return [String]
    def anpp_messages
      anpp_message_li.text
    end
  end
end
