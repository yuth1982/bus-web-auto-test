module Bus
  # This class provides actions for add new partner page section
  class CSSConfigIframe < SiteHelper::Iframe

    #section(:branding_section, BrandingSection, xpath: "//li[@id='nav-cat-site_branding']/ul/li[4]/a")
    element(:css_input, xpath: "//*[@id='site_branding-webrestore_site-tabs']/ul[2]/li[1]/textarea")
    #element(:css_input, css: "#site_branding-webrestore_site-tabs > ul.tab-panes > li.selected > textarea")
    element(:save_changes_btn, xpath: "//*[@id='site_branding-webrestore_site-tabs']/ul[2]/li[7]/p/input")

    def css_header_color_hex
      color_hex_list = ["#FAEBD7", "#00FFFF", "#8A2BE2", "#FF1493"]
      color_hex = color_hex_list[rand(4)]
      puts color_hex
      header_hex = ".content-header{ background-color: " + color_hex +";}"
      footer_hex = ".footer{ background-color: " + color_hex +";}"
      css_input.type_text(header_hex+"      "+footer_hex)
      sleep 3
    end

    def click_save_changes
      save_changes_btn.click
      sleep 5
    end

  end
end