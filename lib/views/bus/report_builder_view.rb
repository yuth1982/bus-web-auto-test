module Bus
  # This class provides actions for report builder view
  class ReportBuilderView < PageObject

    # Private elements
    #
    element(:report_filter, {:id => "job_filter"})
    element(:available_reports_table, {:xpath => "//div[@id='jobs-report_builder-content']/table"})

    # Shared Report Settings section
    element(:report_type_select, {:id => "job_name"})
    element(:report_name_tb, {:id => "job_title"})
    element(:frequency_select, {:id => "job_frequency"})

    # Start date section
    element(:year_select, {:id => "job_start_at_1i"})
    element(:month_select, {:id => "job_start_at_2i"})
    element(:day_select, {:id => "job_start_at_3i"})

    element(:is_active_cb, {:id => "job_active"})

    element(:backup_overdue_after_tb, {:id => "job_backup_overdue_after"})
    element(:save_btn, {:xpath => "//div[@id='jobs-new-content']//input[@value='Save']"})
    element(:delete_btn, {:link => "Delete"})

    #Report Scope Section

    #Email Options Section
    element(:recipients_tb, {:id => "job_subscribers"})
    element(:report_created_txt, {:xpath => "//div[@id='jobs-new-errors']/ul[@class='flash successes']"})

    # Public: Messages for report builder actions
    #
    # Example
    #  @bus_admin_console_page.report_builder_view.message_text
    #  # => "Created Billing Summary Report."
    #
    # Returns success or error message text
    def message_text
      report_created_txt.text
    end

    # Public: Available report and description table rows text (UI)
    #
    # Example
    #    @bus_admin_console_page.report_builder_view.available_reports_tb_rows_text
    #    # =>  [["Billing Summary", "Gives a summary of resources and usage by partner and user group."]]
    #
    # Returns available report table rows text
    def available_reports_tb_rows_text
      available_reports_table.body_rows_text
    end

    # Public: Report filter options
    #
    # Example
    #    @bus_admin_console_page.report_builder_view.report_filters_text
    #    # =>  ["None", "Billing Summary","Billing Detail","Machine Watchlist","Machine Status" ... ...]
    #
    # Returns report filter options
    def report_filters_text
      report_filter.options.map{ |option| option.text}
    end

    # Public: Click report name and display add report view
    #
    # Example
    #    @bus_admin_console_page.navigate_to_add_report_view
    #
    # Returns nothing
    def navigate_to_add_report_view(report_type)
      driver.find_element(:link, report_type).click
    end

    # Public: Find and delete a scheduled report
    #
    # Example
    #
    #  @bus_admin_console_page.report_builder_view.delete_report("Billing Summary Test Report")
    #
    # Returns nothing
    def delete_report(report_name)
      driver.find_element(:link, report_name).click
      delete_btn.click
      alert = driver.switch_to.alert
      alert.accept
      sleep 10
    end

    def build_billing_summary_report(report_name, frequency, start_date, is_active)
      report_name_tb.type_text(report_name)
      frequency_select.select_by(:text, frequency)
      is_active_cb.uncheck unless is_active
      save_btn.click
    end

    def build_billing_detail_report(report_name, frequency, start_date, is_active)
      report_name_tb.type_text(report_name)
      frequency_select.select_by(:text, frequency)
      is_active_cb.uncheck unless is_active
      save_btn.click
    end

    def build_machine_watchlist_report
      raise "No implementation error"
    end

    def build_machine_status_report
      raise "No implementation error"
    end

    def build_resource_added_report
      raise "No implementation error"
    end

    def build_machine_over_quota_report
      raise "No implementation error"
    end
  end
end
