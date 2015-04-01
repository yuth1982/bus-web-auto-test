require 'pathname'
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
      file_name = File.dirname(__FILE__)
      parentPath = File.dirname(Pathname.new(file_name).parent.parent)
      parentPath = parentPath + "/test_data/run.txt"
      #attach_file('filename', "#{QA_ENV['local_file_upload']}")
      attach_file('filename', parentPath)
    end

  end
end