
def bus_login(environment="bus admin console")
  @bus_site = BusSite.new
  case environment
    when "bus admin console"
      @bus_site.login_page.load
      @bus_site.login_page.choose_english
      @admin_username = QA_ENV['bus_username']
      @admin_password = QA_ENV['bus_password']
      @bus_site.login_page.login(@admin_username, @admin_password)
    when "to legacy bus01"
      @bus_site.itemized_login.load
      @admin_username = QA_ENV['bus01_admin']
      @admin_password = QA_ENV['bus01_pass']
      @bus_site.itemized_login.login(@admin_username, @admin_password)
  end
end