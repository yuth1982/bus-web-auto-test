module Bus

  class ReplaceMachineSection < SiteHelper::Section

    # replace machine
    element(:replace_submit_btn, xpath: "//input[@value='Submit']")
    element(:replace_password_input, id: "passwd_check")
    elements(:replace_machine_list_td, xpath: "//form[@id='replace-machine-list']//table//tr/td[2]/a")

    def replace_machine(machine_name)
      password =  QA_ENV['bus_password']
      find(:xpath, "//a[text()='#{machine_name}']/../../td[1]/input").click
      replace_submit_btn.click
      replace_password_input.type_text(password)
      replace_submit_btn.click
    end

    def get_replace_machine_list
      replace_machine_list_td.map{|td|td.text}
    end

  end
end
