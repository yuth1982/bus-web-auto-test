module Phoenix
  # This class provides actions for phoenix registration page
  class DomSelection < SiteHelper::Page

    set_url("https://#{QA_ENV['phoenix_host']}/registration")

    # Private elements
    #
    # Select dom page
    #
    element(:country_select, id: "person_country")
    #
    # Various elements
    #
    element(:next_btn, id: "next-button")
    element(:continue_btn, css: "input.img-button")
    element(:back_btn, id: "back_button")
    element(:submit_btn, id: "submit_button")
    #
    # Public : verify dom elements
    #
    # required: element, element_hash
    #
    # Example
    #
    #   select_country('dom')
    #
    # Returns nothing
    def verify_dom_elements
      add_existence_checker(:country_select, id: "person_country")
      add_existence_checker(:continue_btn, css: "input.img-button")
    end

    #
    # Public : select dom
    #
    # required: person_country - country for user/partner, controls dom
    #
    # Example
    #
    # select_country('dom')
    #
    # Returns nothing
    def select_country(partner)
      country_select.select(partner.company_info.country)
      continue_btn.click
      localize_country!(partner)
    end
      
    def localize_country!(partner)
      case partner.company_info.country
      when 'Germany'
        partner.company_info.country = 'Deutschland'
      end
    end
      
      
  end
end
