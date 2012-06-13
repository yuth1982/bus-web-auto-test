module Bus
  class AdminDetailsView < PageObject

  element :activate_admin_link, {:link => "Activate Admin"}
  element :new_pwd_txt, {:id => "new_password"}
  element :pwd_confirm_txt, {:id => "new_password_confirmation"}

  PWD_SAVE_LOC = "//div[@id='admin-pass-change-%s-content']//input[@value='Save Changes']"
  PWD_CHANGE_SUCC_LOC = "//div[@id='admin-show-%s-errors']/ul[@class='flash successes']"
  #PWD_CHANGE_FAIL_LOC = "//div[@id='admin-show-%s-errors']/ul[@class='flash errors']"

  def update_password new_pwd,pwd_confirm
    new_pwd_txt.type_text new_pwd
    pwd_confirm_txt.type_text pwd_confirm

    @driver.find_element(:xpath, PWD_SAVE_LOC%admin_id).click
    @driver.find_element(:xpath, PWD_CHANGE_SUCC_LOC%admin_id).displayed?
  end

  private

  def admin_id
    activate_admin_link.attribute("onclick").match(/admin-pass-change-(\d+)/)[1].to_s
  end

end
end