module Zimbra
  # This class provides actions for zimbra mail main page
  class MailMainPage < PageObject
    element(:search_input_tb, {:id => "searchField"})
    element(:do_search_btn, {:xpath => "//input[@value='Search']"})
    element(:mail_list_tbody, {:id => "mess_list_tbody"})
    element(:download_att_link, {:link => "Download"})

    # Public: Search email by query
    #
    # Example
    #   @mail_main_page.search_mails("")
    #
    # Returns nothing
    def search_mails(keywords)
      search_input_tb.type_text(keywords)
      do_search_btn.click
    end

    # Public: mail list table body rows element
    #
    # Example
    #   @mail_main_page.mail_list_rows
    #   # => [[Selenium::Element,Selenium::Element,Selenium::Element]]]
    #
    # Returns mail table rows element
    def mail_list_rows
      mail_list.rows
    end

    # Public: Click to view first matched email in search results list
    #
    # Example
    #   @mail_main_page.open_first_mail
    #
    # Returns nothing
    def open_first_mail
      mail_list.rows.first[7].find_element(:tag_name,"a").click
    end

    # Public: Click download link in mail body view
    #         Attachment is sent to download_folder
    # Example
    #   @mail_main_page.download_attachment
    #
    # Returns nothing
    def download_attachment
      download_att_link.click
      puts "Wait 10 seconds to download csv reports file"
      sleep 10
    end

    private
    def mail_list
      mail_list_tbody.parent
    end
  end
end