class BusSite

  def login_page
    Bus::LoginPage.new
  end

  def admin_console_page
    Bus::AdminConsolePage.new
  end

  def user_login_page(subdomain, type = 'mozy')
    Bus::UserLoginPage.new(subdomain, type)
  end

  def user_account_page(subdomain = nil)
    Bus::UserAccountPage.new(subdomain)
  end

  def authentication_failed_page(subdomain = nil)
    Bus::AuthenticationFailedPage.new(subdomain)
  end

  def verify_email_page
    Bus::VerifyEmailPage.new
  end

  def partner_subdomain_page
    Bus::PartnerSubdomainPage.new
  end

end

