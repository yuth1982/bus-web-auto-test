module Aria
  # This class provides actions for search account view
  class SearchAccountView < PageObject

    # Private elements
    #
    element(:search_tb, {:xpath => "//input[@name='inSearchString']"})
    element(:search_btn, {:xpath => "//input[@value='Search']"})

    def search_account(search_text)
      search_tb.type_text(search_text)
      search_btn.click
    end
  end
end