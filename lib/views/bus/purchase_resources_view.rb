module Bus
  class PurchaseResourcesView < PageObject

  element :licenses_server_tb, {:id => "licenses_Server"}
  element :quota_server_tb, {:id => "quota_Server"}
  element :licenses_desktop_tb, {:id => "licenses_Desktop"}
  element :quota_desktop_tb, {:id => "quota_Desktop"}
  element :coupon_code_tb, {:id => "coupon_name"}
  element :submit_btn, {:xpath => "//div[@id='resource-purchase_resources-content']//input[@value='Submit']"}
  element :edit_amounts_link, {:link =>"Edit Amounts"}
  element :resource_purchased_txt, {:xpath => "//div[@id='resource-purchase_resources-content']/div/span"}

  elements :total_prices_td, {:xpath => "//form[@id='purchase_resource_pay_form']/table/tbody/tr/td[4]"}


  RESOURCE_PURCHASED_MSG = "Resources have been added to your account."

  def edit_amounts server_lic_num,server_quota,desktop_lic_num,desktop_quota
    licenses_server_tb.type_text server_lic_num.to_s
    quota_server_tb.type_text server_quota.to_s
    licenses_desktop_tb.type_text desktop_lic_num.to_s
    quota_desktop_tb.type_text desktop_quota.to_s

    submit_btn.click

    raise "Error on calculating resources costs" unless edit_amounts_link.displayed?
  end

  def total_prices_list
    SeleniumHelper.instance.get_elements_text total_prices_td
  end

  def server_keys_price
    total_prices_td[0].text
  end

  def desktop_keys_price
    total_prices_td[1].text
  end

  def server_storage_price
    total_prices_td[2].text
  end

  def desktop_storage_price
    total_prices_td[3].text
  end

  def subtotal_price
    total_prices_td[4].text
  end

  def prorated_subtotal_price
    total_prices_td[5].text
  end

  def discounts_applied_price
    total_prices_td[6].text
  end

  def tax_price
    total_prices_td[7].text
  end

  def total_charges_price
    total_prices_td[8].text
  end

  def purchase
    submit_btn.click
    raise "Error on purchasing resources" unless resource_purchased_txt.text.include? RESOURCE_PURCHASED_MSG
  end
end
end