module Zimbra
  # This class provides actions for zimbra mail main page
  class MailMainPage < PageObject
    element(:search_input_tb, {:id => "searchField"})
    element(:do_search_btn, {:xpath => "//input[@value='Search']"})
    element(:mail_list_tbody, {:id => "mess_list_tbody"})
    element(:download_att_link, {:link => "Download"})

    def search_mails(keywords)
      search_input_tb.type_text(keywords)
      do_search_btn.click
    end


    def mail_list_rows
      mail_list.body_rows
    end

    def open_first_mail
      mail_list.body_rows.first[7].find_element(:tag_name,"a").click
    end

    def download_attachment
      download_att_link.click
      puts "Wait 10 seconds to download csv report file"
      sleep 10
    end

    private
    def mail_list
      mail_list_tbody.parent
    end
  end
end