module Freyja
  class RestoresPage < SiteHelper::Page

    # Private elements
    #
    # Restore wizard
    element(:restore_all_files_btn, xpath: "//a//*[text()='Restore All Files...']")
    element(:restore_name_tb, xpath: "//*[@id='wizard_main']//*[@id='restore_name']")
    element(:next_btn, xpath: "//*[@id='wizard_buttons']//*[@id='button-next']")
    element(:close_btn, xpath: "//*[@id='restore_complete_buttons']//*[@id='button-close']")
    element(:fryr_rb, id: "choose_delivery_method_download_manager")
    element(:archive_rb, id: "choose_delivery_method_archive")
    element(:media_rb, id: "choose_delivery_method_media")
    element(:fryr_download_link, id: "download_download_manager_link")
    element(:begin_download_btn, xpath: "//*[@id='wizard_buttons']//*[@id='button-next']/div[2]")

    # Media restore shipping address info
    element(:order_name_tb, id: "dvd_order_name")
    element(:order_address1_tb, id: "dvd_order_address1")
    element(:order_city_tb, id: "dvd_order_city")
    element(:order_state_tb, id: "dvd_order_state")
    element(:order_zip_tb, id: "dvd_order_zip")
    element(:order_country_select, id: "dvd_order_country")
    element(:order_phonenumber_tb, id: "dvd_order_phonenumber")

    # Media restore credit card info
    element(:cc_name_tb, id: "cc_name")
    element(:cc_number_tb, id: "cc_number")
    element(:cc_expired_date_tb, id: "cc_expired_date")
    element(:cc_cvv2_tb, id: "cc_cvv2")
    element(:agreement_checkbox, id: "agree_with_mozy_policy_check_box")

    # Public: Click restore all files button in details pane
    #
    # Example
    #   @freyja_site.restores.click_restore_all_files_btn
    #
    # Returns nothing
    def click_restore_all_files_btn
      restore_all_files_btn.click
    end

    # Public: Go through the restore wizard for restore all files
    #
    # restore - restore object
    #
    # Example
    #   @freyja_site.restores.create_restore_all_files(restore)
    #
    # Returns nothing
    def create_restore_all_files(restore)
      fill_restore_name(restore.restore_name)
      click_next
      sleep 1
      click_next
      sleep 1
      click_next
      case restore.restore_type
        when 'fryr'
          select_fryr
        when 'archive'
          select_archive
        when 'media'
          select_media(restore)
      end
    end

    # Public: Get restore status
    #
    # restore_id - restore_id of the restore object
    #
    # Example
    #   @freyja_site.restores.get_restore_status(restore_id)
    #
    # @return restore_status
    def get_restore_status(restore_id)
      return find(:xpath, "//tr[@id='#{restore_id}']/td[5]/div").text.to_s
    end

    private

    def fill_restore_name(restore_name)
      restore_name_tb.type_text(restore_name)
    end

    def select_fryr
      fryr_rb.click
      sleep 1
      click_next
      wait_until do
        fryr_download_link.visible?
      end
      fryr_download_link.click
      wait_until do
        begin_download_btn.visible?
      end
      begin_download_btn.click
      wait_until do
        close_btn.visible?
      end
      click_close
    end

    def select_archive
      archive_rb.click
      click_next
      wait_until do
        close_btn.visible?
      end
      click_close
    end

    def select_media(restore)
      media_rb.click
      click_next
      fill_media_address(restore.address_info)
      click_next
      fill_media_payment(restore.credit_card)
      click_next
      wait_until do
        close_btn.visible?
      end
      click_close
    end

    def fill_media_address(address_info)
      order_name_tb.type_text(address_info.name)
      order_address1_tb.type_text(address_info.address)
      order_city_tb.type_text(address_info.city)
      order_state_tb.type_text(address_info.state)
      order_zip_tb.type_text(address_info.zip)
      order_country_select.select(address_info.country)
      order_phonenumber_tb.type_text(address_info.phone)
    end

    def fill_media_payment(credit_card)
      cc_name_tb.type_text(credit_card.full_name)
      cc_number_tb.type_text(credit_card.number)
      cc_expired_date_tb.type_text("#{credit_card.expire_month}/#{credit_card.expire_year}")
      cc_cvv2_tb.type_text(credit_card.cvv)
      agreement_checkbox.click
    end

    def click_next
      next_btn.click
    end

    def click_close
      close_btn.click
    end

  end
end
