module Freyja
  # This class provides actions for upload
  class UploadIframe < SiteHelper::Iframe

    # Public: Upload one file from Actions pane
    #
    # Example
    #   @freyja_site.action_panel_page.upload_iframe.attach_one_file
    #
    # Returns nothing
    def attach_one_file
      attach_file('filename', "#{QA_ENV['local_file_upload']}")
    end

  end
end