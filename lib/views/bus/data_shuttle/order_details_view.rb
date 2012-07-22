module Bus
  class OrderDetailsView < PageObject
    elements(:cancel_order_links, {:link => "cancel"})

    def cancel_latest_order
      cancel_order_links.first.click
    end

    def tables
      driver.find_element(:xpath, "//h3[contains(text(), 'Target Data Center:')]").parent.parent.find_elements(:tag_name,"table")
    end

    def orders_table
      tables[0]
    end

    def latest_order_status
      orders_table.body_rows.first[1].text
    end
  end
end