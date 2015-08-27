module Bus
  # This class provides actions for add new partner page section
  class UpgradeRulesIframe < SiteHelper::Iframe

    element(:create_new_rule_link, xpath: "//a[text()='Create New Rule']")
    element(:rule_save_btn, xpath: "//input[@value='Save Changes']")

    # element for the new added rule line
    element(:rule_version_select, xpath: "//select[@name='rn_version_id[]']")
    element(:version_min_input, xpath: "//input[@name='rn_check_requesting_ver_min[]']")
    element(:version_max_input, xpath: "//input[@name='rn_check_requesting_ver_max[]']")
    element(:version_required_select, xpath: "//select[@name='rn_install_required[]']")
    element(:rule_enabled_select, xpath: "//select[@name='rn_is_enabled[]']")
    element(:install_command_input, xpath: "//input[@name='rn_install_command[]']")


    # Public: add a new rule in Upgrade Rules iframe
    #
    def add_new_rule(rule)
      create_new_rule_link.click
      rule_version_select.select(rule['version name'])
      version_min_input.type_text(rule['min version']) if rule.has_key?('min version')
      version_max_input.type_text(rule['max version']) if rule.has_key?('max version')
      install_command_input.type_text(rule['Install CMD']) if rule.has_key?('Install CMD')
      version_required_select.select(rule['Req?']) if rule.has_key?('Req?')
      rule_enabled_select.select(rule['On?']) if rule.has_key?('On?')
      rule_save_btn.click
    end

    # Public: determine if a rule with specified version name exists in Upgrade Rules
    # If rule exists, return true and array of rule line numbers
    # If not, return false and empty array
    def rule_exists?(version_name)
      has_rule = false
      rule_number = []
      rule_size = all(:xpath, "//tbody[@id='version_rules_tbody']//tr").size
      row = 1
      while row <= rule_size do
        rule_version_name = find(:xpath, "//tbody[@id='version_rules_tbody']//tr[#{row}]//td[1]//select[1]").first_selected_option.text
        if rule_version_name == version_name
          has_rule = true
          rule_number << row
        end
        row = row + 1
      end

      return has_rule, rule_number
    end

    # Public: delete rule according to rule version name and rule lines in upgrade rule lists
    #
    def delete_rule(version_name, rule_lines)
      rule_lines.reverse!
      for line in rule_lines
        find(:xpath, "//tbody[@id='version_rules_tbody']//tr[#{line}]//td[last()]//b").click if version_name == find(:xpath, "//tbody[@id='version_rules_tbody']//tr[#{line}]//td[1]//select[1]").first_selected_option.text
      end
      rule_save_btn.click
    end

  end

end
