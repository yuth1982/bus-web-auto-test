module Bus

  class AddReportSection < SiteHelper::Section

    # Private elements
    #
    # Shared Report Settings section
    element(:report_type_select, id: "job_name")
    element(:report_name_tb, id: "job_title")
    element(:frequency_select, id: "job_frequency")

    # Start date section
    element(:year_select, id: "job_start_at_1i")
    element(:month_select, id: "job_start_at_2i")
    element(:day_select, id: "job_start_at_3i")

    element(:is_active_cb, id: "job_active")

    element(:backup_overdue_after_tb, id: "job_backup_overdue_after")
    element(:save_btn, xpath: "//div[@id='jobs-new-content']//input[@value='Save']")
    element(:delete_btn, xpath: "//a[text()='Delete']")

    #Report Scope Section

    #Email Options Section
    element(:recipients_tb, id: "job_subscribers")
    element(:report_created_txt, xpath: "//div[@id='jobs-new-errors']/ul[@class='flash successes']")

    # Public: Messages for reports builder actions
    #
    # Example
    #  @bus_admin_console_page.report_builder_section.messages
    #  # => "Created Billing Summary Report."
    #
    # Returns success or error message text
    def messages
      report_created_txt.text
    end

    # Public: Find and delete a scheduled reports
    #
    # Example
    #
    #  @bus_admin_console_page.report_builder_section.delete_report("Billing Summary Test Report")
    #
    # Returns nothing
    def delete_report(report_name)
      find_link(report_name).click
      page.suppress_alert
      delete_btn.click
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
          frequency_select.select(report.frequency)
          set_report_start_date(report.start_date)
          is_active_cb.uncheck unless report.is_active
        when Bus::DataObj::BillingDetailReport
          report_name_tb.type_text(report.name)
          frequency_select.select(report.frequency)
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
      year_select.select(yyyy_mm_dd[0])
      month_select.select(yyyy_mm_dd[1])
      day_select.select(yyyy_mm_dd[2])
    end
  end

end
