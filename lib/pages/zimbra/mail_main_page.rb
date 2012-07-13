module Zimbra
  class MailMainPage < PageObject
    element(:search_input_tb, {:id => "searchField"})
    element(:do_search_btn, {:xpath => "//input[@value='Search']"})
    element(:mail_list_tbody, {:id => "mess_list_tbody"})

    def search_mails(keywords)
      search_input_tb.type_text(keywords)
      do_search_btn.click
    end

    def search_results
      mail_list_tbody.parent
    end
  end
end