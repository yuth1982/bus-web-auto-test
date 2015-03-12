module CMS
  # This class provides actions for cms pages
  class ContentPages < SiteHelper::Page

    # creating to verify contents of certain cms pages w/ automation to avoid
    # late breaking issues with production pushes
    # said contents are evolutionary/always changing - will update pages as the change

    set_url("http://mozy.com")

    #---DOWNLOADS PAGE SECTION---
    def download_check_verification
      download_link
      dl_links_verify
      go_to_home_verify
      find(:xpath, "//a[contains(@href,'/')]").click
      download_link
      go_to_pro_verify
      find(:xpath, "//a[contains(@href,'/')]").click
      Log.debug("Prod-188: Verification Complete")
    end

    # check for dl link
    def download_link
      find(:xpath, "//a[contains(@href,'/download')]").click
    end

    # verification of links provided
    def dl_links_verify
      # home & pro
      find(:xpath, "//a[contains(@href,'/home/download')]").present?
      find(:xpath, "//a[contains(@href,'/pro/download')]").present?
      # stash
      find(:xpath, "//a[contains(@href,'/stash/activate')]").present?
      # apple, google, amazon links
      find(:xpath, "//a[contains(@href,'/us/app/mozy')]").present? #IOS
      find(:xpath, "//a[contains(@href,'store/apps')]").present?  #android-google apps
      find(:xpath, "//a[contains(@href,'/Mozy')]").present? #android-amazon
    end

    # pro verification section
    # presently, the following versions are available (this WILL change):
    # win: mozypro-2_22_0_313-49524
    # mac: mozypro-2_11_1_686-49541, 2_9_2_632-47222, 1_7_3_0-12331
    def go_to_pro_verify
      find(:xpath, "//a[contains(@href,'/pro/download')]").click
      sleep 1 # pause just a sec & verify content
      find(:xpath, "//a[contains(@href,'/downloads/mozypro-2_22_0_313-49524.exe')]").present?
      find(:xpath, "//a[contains(@href,'/downloads/mozypro-2_11_1_686-49541.dmg')]").present?
      find(:xpath, "//a[contains(@href,'/downloads/mozypro-2_9_2_632-47222.dmg')]").present?
      find(:xpath, "//a[contains(@href,'/downloads/mozypro-1_7_3_0-12331.dmg')]").present?
    end

    # home verification section
    # presently, the following versions are available (this WILL change):
    # win: mozy-2_22_0_313-49521
    # mac: 2_11_1_686-49538, 2_9_2_632-47219, 1_7_3_0-12328
    def go_to_home_verify
      find(:xpath, "//a[contains(@href,'/home/download')]").click
      sleep 1 # pause just a sec & verify content
      find(:xpath, "//a[contains(@href,'/downloads/mozy-2_22_0_313-49521.exe')]").present?
      find(:xpath, "//a[contains(@href,'/downloads/mozy-2_11_1_686-49538.dmg')]").present?
      find(:xpath, "//a[contains(@href,'/downloads/mozy-2_9_2_632-47219.dmg')]").present?
      find(:xpath, "//a[contains(@href,'/downloads/mozy-1_7_3_0-12328.dmg')]").present?
    end

  end
end
