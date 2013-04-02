Dir.glob("#{File.dirname(__FILE__)}/sections/**/*.rb").each{ |file| require file }
Dir.glob("#{File.dirname(__FILE__)}/pages/**/*.rb").each{ |file| require file }

class AriaSite

  def login_page
    Aria::LoginPage.new
  end

  def admin_tools_page
    Aria::AdminToolsPage.new
  end

  def accounts_page
    Aria::AccountsPage.new
  end

end


