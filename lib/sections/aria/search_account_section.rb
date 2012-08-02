module Aria
  # This class provides actions for search account view
  class SearchAccountSection < PageObject

    # Private elements
    #
    element(:search_tb, {:xpath => "//input[@name='inSearchString']"})
    element(:search_btn, {:xpath => "//input[@value='Search']"})

    # Public: Search account by search text
    #
    # Examples
    #  @bus_admin_console_page.search_account_section.search_account("qa1+test@mozy.com")
    #
    # Returns Nothing
    def search_account(search_text)
      search_tb.type_text(search_text)
      search_btn.click
    end
  end
end