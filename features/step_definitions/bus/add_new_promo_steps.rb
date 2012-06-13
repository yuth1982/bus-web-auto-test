Then /^I should see promotion creation success message$/ do
end

When /^I add a new promotion$/ do
  @promo = Bus::Promotion.new
  @bus_admin_console_page.add_new_promo_view.add_new_account @promo
  @bus_admin_console_page.add_new_promo_view.promo_created_txt.displayed?.should == true
  sleep 10
end