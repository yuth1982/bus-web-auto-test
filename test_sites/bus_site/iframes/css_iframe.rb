module BUS
  class CSSIframe < SiteHelper::Iframe

    section(:branding_section, BrandingSection, xpath: "//li[@id='nav-cat-site_branding']/ul/li[4]/a")

  end
end