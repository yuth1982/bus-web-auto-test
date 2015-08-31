$:.unshift(File.dirname(__FILE__))
require 'sections/change_password_section'

Dir.glob("#{File.dirname(__FILE__)}/sections/**/*.rb").each{ |file| require file }
Dir.glob("#{File.dirname(__FILE__)}/pages/**/*.rb").each{ |file| require file }



class FreyjaSite

  def main_page
    Freyja::MainPage.new
  end

  def options_menu_page
    Freyja::OptionsMenuPage.new
  end

end