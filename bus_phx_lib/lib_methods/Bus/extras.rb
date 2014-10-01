
def display_login_info
  if @partner.partner_info.type == 'MozyHome'
    hash = {:username=>@partner.admin_info.email,:password=>CONFIGS['global']['test_pwd']}
    string = "un: #{@partner.admin_info.email}, pw: #{CONFIGS['global']['test_pwd']}"
  else
    hash = {:admin_username=>@partner.admin_info.email, :username=>@new_users.last.email,:password=>CONFIGS['global']['test_pwd']}
    string = "pn: #{@partner.admin_info.email}, un: #{@new_users.last.email}, pw: #{CONFIGS['global']['test_pwd']}"
  end
  Log.debug(string)
  return hash
end