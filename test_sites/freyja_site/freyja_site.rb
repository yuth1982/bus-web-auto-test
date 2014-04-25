Dir.glob("#{File.dirname(__FILE__)}/sections/**/*.rb").each{ |file| require file }
Dir.glob("#{File.dirname(__FILE__)}/pages/**/*.rb").each{ |file| require file }

class FreyjaSite

  def login_page(partnertype = 'MozyHome')
    Freyja::LoginPage.new(partnertype)
  end

  def freyja_page
    Freyja::FreyjaPage.new
  end

  def mainUI
    Freyja::MainUI.new
  end

  def actionPanel
    Freyja::ActionPanel.new
  end

  def detailPanel
    Freyja::DetailPanel.new
  end

  def restoreWizard
    Freyja::RestoreWizard.new
  end

end

