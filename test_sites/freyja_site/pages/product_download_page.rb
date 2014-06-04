module Freyja

  class ProductDownloadPage < SiteHelper::Page

    element(:view_website_link, css: "div.device > a")

    # Public: click view website
    #
    # Example
    #   @freyja_site.product_download_page.click_view_website
    #
    # Returns nothing
    def click_view_website
      view_website_link.click
    end

  end
end