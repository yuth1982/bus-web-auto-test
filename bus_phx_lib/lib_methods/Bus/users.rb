
def add_users(hash_array)
  #hash_array example:
  # [{"storage_type"=>"Desktop", "devices"=>"10", "enable_stash"=>"yes"},
  # {"storage_type"=>"Desktop", "devices"=>"120", "enable_stash"=>"no"}]

  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['add_new_user'])
  @new_users =[]
  @users ||=[]

  hash_array.each do |hash|
    user = Bus::DataObj::User.new
    hash_to_object(hash, user)
    @new_users << user
    @users << user
  end
  @bus_site.admin_console_page.add_new_user_section.add_new_users(@new_users)
end


def add_users_success_message(num)
  @bus_site.admin_console_page.add_new_user_section.success_messages.should == "Successfully created #{num} user(s)"
end
