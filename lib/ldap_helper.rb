require 'net-ldap'
module LDAPHelper
  USER = 'congshanliu@qa5.mozyops.com'
  PASSWORD = 'QAP@SSw0rd'
  HOST = 'ad01.qa5.mozyops.com'
  PORT = 389
  TREEBASE = 'dc=qa5, dc=mozyops, dc=com'
  EMAIL_POSTFIX = '@test.com'

  # Public: Add user to the AD server with username (cn) and email
  #
  def add_user(user_name, mail = nil)
    dn = "cn=#{user_name}, #{TREEBASE}"
    attr = {
        :cn => "#{user_name}",
        :objectclass => ['top', 'person', 'user', 'organizationalPerson'],
        :sn => "#{user_name}",
        :name => "#{user_name}",
        :givenname => "#{user_name}",
        :mail => mail || "#{user_name}#{EMAIL_POSTFIX}",
        :uid => '123'
    }
    ldap = Net::LDAP.new :host => HOST,
                         :port => PORT,
                         :auth => {
                             :method => :simple,
                             :username => USER,
                             :password => PASSWORD
                         }
    ldap.open do |ldap|
      ldap.add(:dn => dn, :attributes => attr)
    end
    Log.debug("add a user #{user_name} to AD")
  end

  # Public: delete a user in AD by username
  #
  def delete_user(user_name)
    dn = "cn=#{user_name}, #{TREEBASE}"
    ldap = Net::LDAP.new :host => HOST,
                         :port => PORT,
                         :auth => {
                             :method => :simple,
                             :username => USER,
                             :password => PASSWORD
                         }
    ldap.open do |ldap|
      ldap.delete :dn => dn
    end
    Log.debug("delete a user #{user_name} to AD")
  end

  # Public: Update a user's attribute
  #
  # Example
  #   LDAPHelper.update_user('dev_test1', 'mail', 'gsmith@qa5.mozyops.net')
  def update_user(user_name, attribute, value)
    dn = "cn=#{user_name}, #{TREEBASE}"
    ldap = Net::LDAP.new :host => HOST,
                         :port => PORT,
                         :auth => {
                             :method => :simple,
                             :username => USER,
                             :password => PASSWORD
                         }
    ldap.open do |ldap|
      ldap.replace_attribute(dn, attribute, value)
    end
    Log.debug("update a user #{user_name} to AD: #{user_name}, #{attribute}, #{value}")
  end

  # Public: show a user's detail
  #
  def show_user(user_name)
    dn = "cn=#{user_name}, #{TREEBASE}"
    ldap = Net::LDAP.new :host => HOST,
                         :port => PORT,
                         :auth => {
                             :method => :simple,
                             :username => USER,
                             :password => PASSWORD
                         }
    ldap.open do |ldap|
      ldap.search(:base => TREEBASE, :filter => Net::LDAP::Filter.eq('cn', "#{user_name}")) do |entry|
        puts "DN: #{entry.dn}"
        entry.each do |attribute, values|
          puts "   #{attribute}:"
          values.each do |value|
            puts "      --->#{value}"
          end
        end
      end
    end
    Log.debug("show a user #{user_name} in AD")
  end

  # Public: modify a rdn
  #
  # can not use the rename functions, sucks, So I have to use another way, delete it and then add it
  def modify_rdn(user_name, new_name, user)
    dn = "cn=#{user_name}, #{TREEBASE}"
    ldap = Net::LDAP.new :host => HOST,
                         :port => PORT,
                         :auth => {
                             :method => :simple,
                             :username => USER,
                             :password => PASSWORD
                         }
    ldap.open do |ldap|
 #     p ldap.rename(:olddn => dn, :newrdn => "cn=#{new_name}")
      delete_user(user_name)
      add_user(new_name, "#{user}")
    end
    Log.debug("rename user #{user} from #{user_name} to #{new_name} in AD")
  end
end