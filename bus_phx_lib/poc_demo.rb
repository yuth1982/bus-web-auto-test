require_relative 'bus_automation'


#Same test as ircbot.feature Scenario:Create and display MozyPro user information
def bus_demo
  open_browser
  bus_login
  bus_create_partner('MozyPro',{'period'=>1,'base plan'=>'100 GB','server plan'=>'yes','net terms'=>'yes'})
  compare_partner_creation_message("New partner created.")
  partner_enable_sync
  act_as_partner
  add_users([{'storage_type'=>'Desktop','devices'=>10,'enable_stash'=>'yes'}])
  add_users_success_message(1)
  @credentials = display_login_info
end
bus_demo

puts "\n\n You can use these credentials for a client test:\n #{@credentials}"
