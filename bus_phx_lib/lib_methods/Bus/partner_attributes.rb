
def partner_enable_sync
  @bus_site.admin_console_page.partner_details_section.enable_stash
end

def act_as_partner(subpartner=false)
  # Put 'sub' to make a subpartner
  if !subpartner
    @current_partner = @bus_site.admin_console_page.partner_details_section.partner
    @bus_site.admin_console_page.partner_details_section.act_as_partner
    @bus_site.admin_console_page.has_stop_masquerading_link?
  else
    @current_partner = @bus_site.admin_console_page.partner_details_section.subpartner.partner
    @bus_site.admin_console_page.partner_details_section.subpartner.act_as_partner
    @bus_site.admin_console_page.has_content?(@subpartner.company_name)
  end
  @partner_id = @bus_site.admin_console_page.current_partner_id


end