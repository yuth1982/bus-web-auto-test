

Then /^Machine search results should be:$/ do |results_table|
  actual = @bus_site.admin_console_page.search_list_machines_section.search_results_hashes
  expected = results_table.hashes
  expected.each do |col|
    col.each do |k,v|
      case k
        when 'User'
          v.gsub!(/@new_user_email/, @user.email) unless @user.nil?
        when 'Created'
          v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
        else
          # do nothing
      end
    end
  end
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end
When /^I export the machines csv$/ do
  @bus_site.admin_console_page.search_list_machines_section.export_csv
end
Then /^(.+) and (.+) are downloaded$/ do |user, machine|
  @bus_site.admin_console_page.search_list_machines_section.machine_user_csv_files(user, machine).should == [user, machine]
end