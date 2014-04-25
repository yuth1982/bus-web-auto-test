And /^I fill out the restore wizard$/ do |restore_table|
  #(.+)
  @restore = Freyja::DataObj::Restore.new

  attributes = restore_table.hashes.first

  @restore.restore_name = attributes["restore_name"] unless attributes["restore_name"].nil?
  @restore.restore_date = attributes["restore_date"] unless attributes["restore_date"].nil?
  @restore.incl_deleted = attributes["incl_deleted"] unless attributes["incl_deleted"].nil?
  @restore.restore_format = attributes["restore_format"] unless attributes["restore_format"].nil?
  @restore.dvd_to_biz = attributes["dvd_to_bus"] unless attributes["dvd_to_bus"].nil?
  @restore.use_company_info = attributes["use_company_info"] unless attributes["use_company_info"].nil?

  #@freyja_site.restore.create_restore(@restore)
  @freyja_site.restoreWizard.create_restore(@restore)

end