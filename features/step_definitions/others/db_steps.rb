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