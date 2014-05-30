module Freyja

  class SearchPage < SiteHelper::Page

      element(:search_input, id: 'search-input')           #xpath: "//*[@id='search-input']"
      element(:conduct_search_btn, css: 'div.search-magnify-icon.icon-search-filter')


      def input_search(search_string)
        puts search_string
        search_input.type_text(search_string)
      end

      def execute_search
        conduct_search_btn.click
      end

      def verify_search_result(search_string)
        wait_until do
          !find(:css, '#stash-layout > header').text.match(/.\*#{search_string}*/).nil?
        end
      end

  end
end