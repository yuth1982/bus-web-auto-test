module Phoenix
  class NewAdminFillout

    set_url("#{PHX_ENV['phx_host']}")

    # Private elements
    #
    # Admin Info Page
    #
    element(:new_admin_display_name_tb, id: "person_display_name")
    element(:new_admin_username_tb, id: "person_username")
    element(:new_admin_zip_tb, id: "person_zip")
    element(:new_admin_country_select, id: "person_country")
    element(:password_tb, id: "person_password")
    element(:reenter_password_tb, id: "person_password_confirmation")

    #	Public : fill out admin info
    #
    #	required: admin name - name of primary admin on acct
    #	required: email - email adddress for admin, becomes user name
    #	required: password - must be @ least 2 chars
    #	required: re-entry password - same password re-entered
    #	required: country - country for admin (usually same as dom)
    #	optional: zip - postal code for admin
    #
    #	Example
    #
    #		admin_info_fillout('adminname', 'username', 'password', 'country', 'zip')
    #
    #	Returns nothing
    def admin_info_fill_out(adminname, username, password, country, zip)
      new_admin_display_name_tb.type_text(adminname)
      new_admin_username_tb.type_text(username)
      password_tb.type_text(password)
      reenter_password_tb.type_text(password)
      new_admin_country_select.select(country)
      new_admin_zip_tb.type_text(zip)
      continue_btn.click
    end
  end
end