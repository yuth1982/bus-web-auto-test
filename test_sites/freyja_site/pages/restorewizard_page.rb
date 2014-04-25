module Freyja
  class RestoreWizard < SiteHelper::Page

    element(:event_history_table, id: 'dt_all_restores_wrapper')
    element(:event_history_restore_icon, css: 'span.events.restore')
    element(:restore_dl_mgr_select, id: 'choose_delivery_method_download_manager')
    element(:restore_archive_select, id: 'choose_delivery_method_archive')
    element(:restore_dvd_select, id: 'choose_delivery_method_media')
    element(:restore_download_mgr_link, id: 'download_download_manager_link')
    element(:restore_id, xpath: '//*[@id="restore_id"]')
    element(:num_files_restored, xpath: '//*[@id="restore_num_files"]')
    element(:begin_dl_btn, xpath: '//*[@id="button-next"]/div[2]')
    element(:devices, id: 'backup_tab_button')
    element(:close, css: '#button-close > div.wizard-button-end.button-left')

    def choose_devices()
      devices.click
    end

    #interation through the restore wizard - restore all instance
    def create_restore(restore)
      input_restore_name(restore)
      click_next
      restore_date(restore)
      click_next
      include_deleted(restore)
      click_next
      restore_format(restore)
      sleep 2
    end

    #enter the name of the restore
    def input_restore_name(restore)
      find(:css, '#wizard_main > #restore_name').type_text(restore.restore_name)
    end

    #include deleted files
    #if true, check the checkbox
    #if false, leave alone
    def include_deleted(restore)
      if restore.incl_deleted.eql?("true")
        find(:id, 'include_deleted_checkbox').click
      else
        find(:id, 'include_deleted_checkbox')
        Log.debug("nothing checked for include deleted files")
      end
    end

    #date selection
    def restore_date(restore)
      find(:css, 'a.ui-state-default.ui-state-highlight.ui-state-active').click
    end

    #restore format selection
    def restore_format(restore)
      #download manager choice
      if restore.restore_format.eql?("dl_mgr")
        restore_format_download_mgr
        #find(:id, 'choose_delivery_method_download_manager').click
        #direct download of archive choice
      else if restore.restore_format.eql?("archive")
             restore_format_archive
             #find(:id, 'choose_delivery_method_archive').click
             #request a dvd choice
           else
             restore_format_dvd(restore)
           end
      end
    end

    def restore_format_archive
      restore_archive_select.click
      click_next
      sleep 3
      click_close
    end

    def restore_format_download_mgr
      restore_dl_mgr_select.click
      click_next
      wait_until do
        restore_download_mgr_link.visible?
      end
      restore_download_mgr_link.click
      #wait_until do
      #begin_dl_btn.visible?
      #end
      sleep 60
      begin_dl_btn.click
      wait_until do
        close.visible?
      end
      click_close
    end

    def restore_format_dvd(restore)
      find(:id, 'choose_delivery_method_media').click
      click_next
      dvd_order_fill_out_address(restore)
      click_next
      dvd_payment(restore)
      click_next
      sleep 3
      click_close
    end

    #fill out dvd order info for the destination
    def dvd_order_fill_out_address(restore)
      find(:id, 'dvd_order_name').type_text(restore.restore_name+"-12345")
      find(:id, 'dvd_order_address1').type_text("123 test ave.")
      find(:id, 'dvd_order_city').type_text("Boise")
      find(:id, 'dvd_order_state').type_text("ID")
      find(:id, 'dvd_order_zip').type_text("12345")
      find(:id, 'dvd_order_country').select("United States")
      find(:id, 'dvd_order_phonenumber').type_text("987-654-3210")

      dvd_to_business(restore)
    end

    #fil out order info for the dvd payment
    def dvd_payment(restore)
      find(:id, 'cc_name').type_text("jane doe")
      find(:id, 'cc_number').type_text("4111111111111111")
      find(:id, 'cc_expired_date').type_text("01/2017")
      find(:id, 'cc_cvv2').type_text("111")

      if restore.use_company_info.eql?("false")
        find(:id, 'same_as_ship_addr_checkbox').click
        #for prod just use 'same as'
        find(:id, 'cc_address').type_text("13131 mockingbird lane")
        find(:id, 'cc_city').type_text("Crazyville")
        find(:id, 'cc_state').type_text("ID")
        find(:id, 'cc_zip').type_text("66666")
        find(:id, 'cc_country').select("United States")
      end
      find(:id, 'agree_with_mozy_policy_check_box').click
    end


    def dvd_to_business(restore)
      if restore.dvd_to_biz.eql?("false")
        find(:id, 'dvd_order_address_type_r').click
      else
        find(:id, 'dvd_order_address_type_b').click
        Log.debug("WARNING: sending personal acct restore info to a business?")
      end
    end

    #clicking the next button
    def click_next
      find(:css, '#wizard_buttons > #button-next > div.wizard-button-content').click
    end

    #clicking the close button
    def click_close
      #find(:css, '#button-close > div.wizard-button-end.button-left').click
      close.click
    end

    #clicking the cancel button
    def click_cancel
      find(:css, '#wizard_buttons > #button-cancel > div.wizard-button-content').click
    end

    #clicking the back button
    def click_back
      find(:css, '#button-back > div.wizard-button-content').click
    end

    #click_ok_cancel
    def click_ok
      find(:css, '#flash > div.buttons.clearfix > div.inside > a.button.button-default > span.text').click
    end

    # Public: Restore Manipulation
    #
    # Example
    #    DBHelper.get_restore_data(restore.restore_name)
    #    # =>  ["TESTRESTORE12345","123","4567"]
    #
    # Returns restore item in desired state

    def get_general_restore_data(restore)
      RestoreHelper.get_restore_data(restore.restore_name)
      #adding values to restore data object
      restore.restore_id = @@restores_id
      restore.num_files = @@number_files
      restore.machine_id = @@machine_number

    end


    def restore_in_history(restore)
      event_history_restore_icon.click
      get_general_restore_data(restore)

      wait_until do
        !find(:xpath, "//tr[@id='#{restore.restore_id}']/td[5]/div").text.match(/.*Processing*/).nil?
      end
    end

    def media_restore_in_history(restore)
      event_history_restore_icon.click
      get_general_restore_data(restore)

      wait_until do
        !find(:xpath, "//tr[@id='#{restore.restore_id}']/td[5]/div").text.match(/.*In Progress*/).nil?
      end
    end

    def dl_restore_in_history(restore)
      event_history_restore_icon.click
      get_general_restore_data(restore)

      wait_until do
        !find(:xpath, "//tr[@id='#{restore.restore_id}']/td[5]/div").text.match(/.*Ready for Download*/).nil?
      end
    end


    def event_hist_filters
      filter_select.options.map{ |option| option.text}
    end


    def event_history_table_text
      event_history_table.text
    end

    # Public: First 6 columns of event history table table body rows text
    #
    # Example
    #   @bus_admin_console_page.scheduled_reports_section.reports_table_rows
    #   # => [["Billing Summary Test Report", "Billing Summary", "@email", "Daily", "Run"]]
    #
    # Returns first 6 columns of event history table rows text
    def event_history_table_rows
      event_history_table.rows_text.map{|row| row[0..4]}
    end

    def event_history_table_hashes
      event_history_table.hashes
    end

    # Public: Find first matched event hist item row text by name
    #
    # Example
    #   @bus_admin_console_page.scheduled_reports_section.find_report("Billing Summary Test Report")
    #   # => ["Billing Summary Test Report", "Billing Summary", "qa1+ronald+parker+2237@mozy.com", "Daily", "Run", "Wed Aug 01, 2012", "Download", "-"]
    #
    # Returns first matched history items row text
    def find_restore_item(restore)
      event_history_table.rows.select{ |row| row[0].text == restore.restore_name}.first
    end


  end
end