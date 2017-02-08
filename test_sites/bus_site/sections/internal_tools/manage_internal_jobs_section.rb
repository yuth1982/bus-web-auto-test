module Bus
  # This class provides action for managing on Manage Internal Jobs sections
  class ManageInternalJobsSection < SiteHelper::Section

    element(:parameters_tb, xpath: '//textarea[@name="args"]')
    element(:note_tb, xpath: '//input[@name="note"]')
    element(:start_job_btn, xpath: '//input[@value="Start Job"]')

    #==============================
    # Public : setup a internal job
    # Params : @partner_id, id(s) of partner(s)
    #          @not, job note
    # Return : none
    #==============================
    def setup_internal_job(partner_id, note)
      Log.debug "LogQA: parameter is " + partner_id
      parameters_tb.type_text(partner_id)
      note = note
      Log.debug "LogQA: Note is - " + note
      note_tb.type_text(note)
    end

    #==============================
    # Public : click submit button to start a internal job
    #==============================
    def submit_internal_job
      start_job_btn.click
      sleep(30)
    end

    #==============================
    # Public : refresh the section and wait for the job finished. Timeout = 90 seconds.
    # Return : true for done, false for not Done.
    #==============================
    def wait_internal_job_done(note)
      @note = note
      i = 0
      job_done = false
      while job_done == false && i < 3
        Log.debug "LogQA : refresh the Manage Jobs section"
        find(:xpath, "//div[@id='internal-manage_jobs-content']/../h2/a[@class='mod-button']").click
        Log.debug "LogQA : " + find(:xpath, "//div[@id='internal-manage_jobs-content']//td[text()='#@note']/../td[3]").text()
        job_done = true if find(:xpath, "//div[@id='internal-manage_jobs-content']//td[text()='#@note']/../td[3]").text() != ""
        if job_done
          Log.debug "LogQA : job is done."
          break
        end
        i = i + 1
        sleep(30)
      end
      job_done
    end


    #==============================
    # Public : submit a Start Job on Manage Internal Tools, loop 3 times to check the job succeed
    #          by checking the <End> time is shown on Manage Jobs table.
    # Params : @partner_id, id(s) of partner(s)
    # Return : none
    # Status : Deprecated
    #==============================
    def start_internal_job(partner_id)
      Log.debug "LogQA: parameter is " + partner_id
      parameters_tb.type_text(partner_id)
      note = partner_id + "_#{Time.now.strftime("%H%M")}".downcase
      Log.debug "LogQA: Note is - " + note
      note_tb.type_text(note)
      start_job_btn.click
      sleep(30)
      @note = note
      i = 0
      job_done = false
      while job_done == false && i < 3
        Log.debug "LogQA : refresh the Manage Jobs section"
        find(:xpath, "//div[@id='internal-manage_jobs-content']/../h2/a[@class='mod-button']").click
        Log.debug "LogQA : " + find(:xpath, "//div[@id='internal-manage_jobs-content']//td[text()='#@note']/../td[3]").text()
        job_done = true if find(:xpath, "//div[@id='internal-manage_jobs-content']//td[text()='#@note']/../td[3]").text() != ""
        Log.debug "LogQA : job is done." if job_done
        i = i + 1
        sleep(30)
      end
    end

  end
end