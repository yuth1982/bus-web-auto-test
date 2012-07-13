module Bus
  class ReportBuilderView < PageObject

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

    def get_add_report_view(report_type)
      driver.find_element(:link, report_type).click

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

    end

    def build_machine_status_report

    end

    def build_resource_added_report

    end

    def build_machine_over_quota_report

    end

    def build_report(frequency, report_type, report_name)
      # make sure report type is correct
      report_type_select.select_by(:text,report_type)

      case
        when report_type == "Billing Summary"
          fill_billing_summary_settings(report_name)
        when report_type == "Billing Detail"
          fill_billing_detail_settings(report_name)
        when report_type == "Machine Watchlist"
          fill_machine_watchlist_settings(report_name)
        when report_type == "Machine Status"
          fill_machine_status_settings()
        when report_type == "Resources Added"
          fill_resource_added_settings
        when report_type == "Machine Over Quota"
          fill_machine_over_quota_settings
        else
          raise "Unknown report type #{report_type}"
      end
      frequency_select.select_by(:text, frequency)
      save_btn.click
    end

    def delete_report(report_name)
      driver.find_element(:link, report_name).click
      delete_btn.click
      alert = driver.switch_to.alert
      alert.accept
      sleep 10
    end
  end
end
