require File.expand_path('../../lib/ldap_helper', __FILE__)
include LDAPHelper
require 'logger'
require 'forgery'

Log = Logger.new(STDOUT)
Log.level = Logger::DEBUG

p "default password: #{PASSWORD}, default email postfix: #{EMAIL_POSTFIX}"

# example for add a user with random username and email prefix, fixed email postfix
#add_user(user_name = 'First Last' , mail = 'email@mozy.com', nil,nil,nil,nil,email_postfix = '@testemail.com')

# example for add a user with default email and email postfix
#add_user(user_name = 'HarryPotter')

# example for add a user with emc email address to test email receiving
#1.upto(3) {|x| add_user(user_name = "Harry Potter #{x.to_s}" , mail = "harry.potter#{x.to_s}+#{Time.now.strftime("%Y%m%d%H%M")}@emc.com")}

# example for add a user with uid to test fixed attribute
#add_user(user_name = 'LdapTest',nil,nil,nil,nil,nil,nil, uid = '334')
#show_user(user_name = 'LdapTest')