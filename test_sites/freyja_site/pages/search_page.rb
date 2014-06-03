module Freyja

  class SearchPage < SiteHelper::Page

      element(:search_input, xpath: "//*[@id='search-input']")           #        id: 'search-input'
      element(:conduct_search_btn, xpath: "//section[@id='application']/header/div[2]/div/div")


      def input_search(search_string)
        sleep 2
        search_input.type_text(search_string)
        search_input.click
      end

      def input_search_device(search_string)
        sleep 2
        search_input.type_text(search_string)
      end

      def execute_search
        sleep 5
        conduct_search_btn.click
      end

      def verify_search_result(search_string)
        sleep 1
        page.has_content?("Search Results for '"+search_string.to_s+"'")
        sleep 10
      end

  end
end