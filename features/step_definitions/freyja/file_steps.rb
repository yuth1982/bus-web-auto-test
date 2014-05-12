When /^I choose one file from backup$/ do
  @freyja_site.files_page.choose_one_backup_file
end

When /^I choose one file from sync/ do
  @freyja_site.files_page.choose_one_sync_file
end

When /^I choose one folder from backup$/ do
  @freyja_site.files_page.choose_one_backup_folder
end