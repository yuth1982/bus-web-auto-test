module Bus
  class AdminDetailsView < PageObject

    element(:activate_admin_link, {:link => "Activate Admin"})
    element(:new_pwd_txt, {:id => "new_password"})
    element(:pwd_confirm_txt, {:id => "new_password_confirmation"})

    element(:act_as_link, {:partial_link_text => "Act as"})

    def update_password new_pwd,pwd_confirm
      new_pwd_txt.type_text new_pwd
      pwd_confirm_txt.type_text pwd_confirm
      pwd_confirm_txt.parent.next_sibling.find_element(:xpath, "//input[@value='Save Changes']").click
      sleep 5
    end
  end
end