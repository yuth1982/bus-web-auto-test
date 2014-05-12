And /^I choose Large Download Options$/ do
  @freyja_site.actions_pane_page.click_large_download_options
end

And /^I delete one file from actions pane$/ do
  @freyja_site.actions_pane_page.delete_one_file
end

Then /^file is Deleted$/ do
  @freyja_site.actions_pane_page.check_file_deleted
end

And /^I include deleted files$/ do
  @freyja_site.actions_pane_page.include_deleted_files
end

And /^I exclude deleted files$/ do
  @freyja_site.actions_pane_page.exclude_deleted_files
end

And /^I Delete files$/ do
  @freyja_site.actions_pane_page.delete_files
end
