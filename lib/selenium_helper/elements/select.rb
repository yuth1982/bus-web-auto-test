module AutomationWebDriver
  module Elements
    module Select
      # Public: Deselect options by visible text, index or value.
      #
      def deselect_by(how, what)
        case how
          when :text
            select_by_text(what, true, use_arrow_key)
          when :index
            select_by_index(what, true, use_arrow_key)
          when :value
            select_by_value(what, true, use_arrow_key)
          else
            raise ArgumentError, "Unable to select options by #{how.inspect}"
        end
      end

      # Public: Get all options for this select element
      #
      def options
        self.find_elements(:tag_name, "option")
      end

      # Public: Get all option's text for this select element
      #
      def options_text
        options.map{ |opt| opt.text}
      end

      # Public: Get all option's values for this select element
      #
      def options_values
        options.map{ |opt| opt.value}
      end

      # Public: Select options by visible text, index or value.
      #
      # Example
      #   element.select_by(:text, "10 GB, ")
      #
      # Returns nothing
      def select_by(how, what, use_arrow_key=false)
        case how
          when :text
            select_by_text(what, false, use_arrow_key)
          when :index
            select_by_index(what, false, use_arrow_key)
          when :value
            select_by_value(what, false, use_arrow_key)
          else
            raise ArgumentError, "Unable to select options by #{how.inspect}"
        end
      end

      # Public: Get all selected options for this select element
      #
      #
      # Returns Array<Element>
      def selected_options
        options.select { |e| e.selected? }
      end

      # Public: Get the first selected option in this select element
      #
      def first_selected_option
        option = options.find { |e| e.selected? }
        option or raise Selenium::WebDriver::Error::NoSuchElementError, 'no options are selected'
      end

      private

      def select_by_text(what, deselect, use_arrow_key)
        index = options_text.index{ |opt| opt=~/#{Regexp.escape(what)}/ }
        raise Selenium::WebDriver::Error::NoSuchElementError, "Unable to find option text '#{what}' in select options" if index.nil?
        select_by_index(index, deselect, use_arrow_key)
      end

      def select_by_value(what, deselect, use_arrow_key)
        index = options_values.index{ |opt| opt=~/#{Regexp.escape(what)}/ }
        raise Selenium::WebDriver::Error::NoSuchElementError, "Unable to find option value '#{what}' in select options" if index.nil?
        select_by_index(index, deselect, use_arrow_key)
      end

      def select_by_index(new_index, deselect, use_arrow_key)
        if use_arrow_key
          current_index = options.index(first_selected_option)
          diff = new_index - current_index
          if diff > 0
            diff.abs.times do
              sleep 0.5 # wait between each arrow down movement
              self.send_keys([:arrow_down])
            end
          else
            diff.abs.times do
              sleep 0.5 # wait between each arrow up movement
              self.send_keys([:arrow_up])
            end
          end
        else
        options[new_index].click unless options[new_index].selected?^deselect
        end
      end
    end
  end
end