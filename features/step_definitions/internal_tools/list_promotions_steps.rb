When /^I search promition (.+)$/ do |promo_name|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['list_promotions'])
  @bus_site.admin_console_page.list_promotions_section.search_promotion(promo_name)
end