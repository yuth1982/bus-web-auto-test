module Bus
  # This class provides actions for add new pro plan section
  class AddNewProPlanSection < SiteHelper::Section
    element(:plan_name_tb, id: "plan_name")
    element(:plan_company_type_select, id: "plan_company_type")
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
      plan_company_type_select.select(pro_plan.comp_type)
      plan_name_tb.type_text(pro_plan.name)
      find(:id, "period_M").click
      quota_price_tb.type_text(pro_plan.price_per_gb.to_s)
      minimum_quota_tb.type_text(pro_plan.min_gb.to_s)

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
