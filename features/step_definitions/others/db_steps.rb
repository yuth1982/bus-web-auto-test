When /^I get a user email from the database$/ do
  @existing_user_email = DBHelper.get_user_email
  Log.debug("user email from database = #{@existing_user_email}")
end

When /^I get a (MH|MP|ME|MEO|MC) user username from the database$/ do |parent|
  @existing_user_email = DBHelper.get_user_username(parent)
end

When /^I get an admin email from the database$/ do
  @existing_admin_email = DBHelper.get_admin_email
  Log.debug("admin email from database = #{@existing_admin_email}")
end

When /^I get a Mozy Home user email from the database$/ do
  @existing_user_email = DBHelper.get_mh_user_email
  Log.debug("Mozy Home user email from database = #{@existing_user_email}")
end

When /^I get a suspended user email from the database$/ do
  @existing_user_email = DBHelper.get_suspended_user_email
  Log.debug("Mozy Home suspended user email from database = #{@existing_user_email}")
end

When /^I get a deleted user email from the database$/ do
  @existing_user_email = DBHelper.get_deleted_user_email
  Log.debug("Mozy Home deleted user email from database = #{@existing_user_email}")
end

When /^The( subpartner)? (user|admin|user and admin) password policy from (database|rails console) will be$/ do |sub, type, db, table|
  Log.debug "partner id is #{@partner_id}"
  type = 'all' if type == 'user and admin'
  if db == 'database'
    raise 'You cannot get password policy from database' unless sub.nil?
    password_policy = DBHelper.get_db_password_config(@partner_id, type)
  else
    password_policy = SSHHelper.get_ssh_password_config(@partner_id, type)
  end
  @password_policy_id = password_policy['id'].to_i
  table.hashes.first.each do |k, v|
    password_policy[k].should == v
  end
end

Then /^The (user|admin) should use default password policy$/ do |type|
  DBHelper.get_db_password_config(@partner_id, type).nil?.should be_true
  DBHelper.get_db_password_config(@partner_id, 'all').nil?.should be_true
end

Then /^The (user|admin|user and admin) password will contains at least (\d+) of the following types of charactors$/ do |type, num, table|
  character_classes = DBHelper.get_password_character_classes(@password_policy_id)
  (character_classes.size >= num.to_i).should be_true
  character_classes.each do |character|
    table.headers.include?(character).should be_true
  end
end
