require_relative 'config_section_iframe'
require_relative 'console_section_iframe'
module Bus
  # This class provides actions for add new admin section
  class BrandingSection < SiteHelper::Section

    #iframe(:cb_iframe, CSSBrandingIframe, :css, 'iframe[name^=iframe_]')
    iframe(:cb_iframe, ConfigIframe, :xpath, "//*[@id='site_branding-webrestore_site-content']/iframe")
    iframe(:console_iframe, ConsoleIframe, :xpath, "//*[@id='site_branding-console-content']/iframe")


  end
end
