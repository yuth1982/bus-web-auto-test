When /^I get a user email from the database$/ do
  @existing_user_email = DBHelper.get_user_email
  Log.debug("user email from database = #{@existing_user_email}")
end

When /^I get an admin email from the database$/ do
  @existing_admin_email = DBHelper.get_admin_email
  Log.debug("admin email from database = #{@existing_admin_email}")
end