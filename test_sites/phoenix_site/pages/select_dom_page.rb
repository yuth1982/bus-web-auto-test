# encoding: utf-8
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
      sleep 2 # take a sec and then check the url - ensures we are @ correct dom location
      verify_domain(partner)
    end

    def localize_country(partner)
      case partner.company_info.country
        when 'Germany'
          country_select.select('Deutschland')
        else
          country_select.select(partner.company_info.country)
      end
    end

    # redmine: 103781,82333
    # per the a combination of comments in redmine tickets above and entries from countries yaml file
    # yaml file first, then corrections based on redmine tickets.
    # purpose is to ensure prospective user/partners correct linguistic treatment according to nationality selection
    def verify_domain(partner)
      case partner.company_info.country
        # german - lang specific
        when ('Schweiz' || 'Austria' || 'Switzerland' || 'Deutschland' || 'Germany' || 'Österrreich');
          url.eql?(/https?:\/\/secure.mozy.de\/registration\/[\S]+location\/[\S]+/);
        # french - lang specific
        when ('France' || 'Suisse' || 'Canada' || 'Burkina Faso' || 'Niger' || 'Senegal' || 'Gabun' || 'Mayotte' ||
            'Mali' || 'Rwanda' || 'Belgique' || 'Ivory Coast' || 'Haiti' || 'Burundi' || 'Togo' || 'Congo' || 'Gabon' || 'Comoros' || 'Equatorial Guinea' || 'Guadeloupe' ||
            'Djibouti' || 'Luxembourg' || 'Seychelles' || 'Monaco' || 'Reunion' || 'New Caledonia' || 'Wallis and Futuna' ||
            'French Polynesia' || 'French Southern Territories' || 'French Guiana' || 'Martinique' || 'Saint Pierre and Miquelon' || 'Bénin' || 'Guinée' || 'Côte d’Ivoire') ;
          url.eql?(/https?:\/\/secure.mozy.fr\/registration\/[\S]+location\/[\S]+/);
        # ireland - mainstream EU
        when ('Andorra' || 'Albania' || 'Netherlands Antilles' || 'Bosnia and Herzegovina' || 'Belgium' || 'Bulgaria' ||
            'Estonia' || 'Spain' || 'Europe' || 'Finland' || 'Greece' || 'Croatia' || 'Greenland' || 'Faroe Island' ||
            'Ireland' || 'Iceland' || 'Italy' || 'Lithuania' || 'Luxembourg' || 'Monaco' || 'Montenegro' || 'Czech Republic' ||
            'Martinique' || 'Netherlands' || 'Poland' || 'Portugal' || 'Slovenia' || 'San Marino' || 'Holy See') ;
          url.eql?(/https?:\/\/secure.mozy.ie\/registration\/[\S]+location\/[\S]+/);
        # united kingdom
        when ('United Kingdom' || 'Isle of Man' || 'Falkland Islands' || 'Jersey' || 'British Ind Ocean Terr.' || 'South Georgia' || 'Saint Helena' || 'Pitcairn');
          url.match(/https?:\/\/secure.mozy.co.uk\/registration\/[\S]+location\/[\S]+/)
        else
        # us dom - encompasses all those not mentioned here
          url.eql?(/https?:\/\/secure.mozy.com\/registration\/[\S]+location\/[\S]+/);
      end
    end
  end
end
