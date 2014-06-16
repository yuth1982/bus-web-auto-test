require_relative 'css_config_section_iframe'
module Bus
  # This class provides actions for add new admin section
  class CSSBrandingSection < SiteHelper::Section

    #iframe(:cb_iframe, CSSBrandingIframe, :css, 'iframe[name^=iframe_]')
    iframe(:cb_iframe, CSSConfigIframe, :xpath, "//*[@id='site_branding-webrestore_site-content']/iframe")
  end
end
