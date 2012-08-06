module Bus
  # This class provides actions for reports builder page section
  class ReportBuilderSection < PageObject

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

    # Public: Messages for reports builder actions
    #
    # Example
    #  @bus_admin_console_page.report_builder_section.message_text
    #  # => "Created Billing Summary Report."
    #
    # Returns success or error message text
    def message_text
      report_created_txt.text
    end

    # Public: Available reports and description table rows text (UI)
    #
    # Example
    #    @bus_admin_console_page.report_builder_section.available_reports_tb_rows_text
    #    # =>  [["Billing Summary", "Gives a summary of resources and usage by partner and user group."]]
    #
    # Returns available reports table rows text
    def available_reports_tb_rows_text
      available_reports_table.rows_text
    end

    # Public: Report filter options
    #
    # Example
    #    @bus_admin_console_page.report_builder_section.report_filters_text
    #    # =>  ["None", "Billing Summary","Billing Detail","Machine Watchlist","Machine Status" ... ...]
    #
    # Returns reports filter options
    def report_filters_text
      report_filter.options.map{ |option| option.text}
    end

    # Public: Click reports name and display add reports view
    #
    # Example
    #    @bus_admin_console_page.navigate_to_add_report_section
    #
    # Returns nothing
    def navigate_to_add_report_section(report_type)
      driver.find_element(:link, report_type).click
    end

    # Public: Find and delete a scheduled reports
    #
    # Example
    #
    #  @bus_admin_console_page.report_builder_section.delete_report("Billing Summary Test Report")
    #
    # Returns nothing
    def delete_report(report_name)
      driver.find_element(:link, report_name).click
      delete_btn.click
      alert = driver.switch_to.alert
      alert.accept
      sleep 10
    end

    # Public: Build a report
    #
    # Example
    #
    # Returns nothing
    def build_report(report)
      case report
        when Bus::DataObj::BillingSummaryReport
          report_name_tb.type_text(report.name)
          frequency_select.select_by(:text, report.frequency)
          set_report_start_date(report.start_date)
          is_active_cb.uncheck unless report.is_active
        when Bus::DataObj::BillingDetailReport
          report_name_tb.type_text(report.name)
          frequency_select.select_by(:text, report.frequency)
          set_report_start_date(report.start_date)
          is_active_cb.uncheck unless report.is_active
        else
          raise "Unknown report class"
      end
      save_btn.click
    end

    private
    def set_report_start_date(date)
      yyyy_mm_dd = date.split
      year_select.select_by(:text, yyyy_mm_dd[0])
      month_select.select_by(:text, yyyy_mm_dd[1])
      day_select.select_by(:text, yyyy_mm_dd[2])
    end
  end
end
