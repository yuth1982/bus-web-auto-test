# Public: Add extension method to Element class
#
class Selenium::WebDriver::Element
  include AutomationWebDriver::Elements::CheckBox
  include AutomationWebDriver::Elements::Link
  include AutomationWebDriver::Elements::Table
  include AutomationWebDriver::Elements::TextField

  # Public: element's id attribute value
  #
  # Returns a string of element's id attribute value
  def id
    attribute("id")
  end

  # Public: element's name attribute value
  #
  # Returns a string of element's name attribute value
  def name
    attribute("name")
  end

  # Public: element's value attribute value
  #
  # Returns a string of element's value attribute value
  def value
    attribute("value")
  end

  # Public: Get parent element of current element
  #
  # Returns parent element of current element
  def parent
    find_element(:xpath, "..")  #parent::*[1]
  end

  # Public: Get next sibling element of current element
  #
  # Returns next sibling element of current element
  def next_sibling
    find_element(:xpath, "following-sibling::*[1]")
  end

  # Public: Get previous sibling element of current element
  #
  # Returns previous sibling element of current element
  def previous_sibling
    find_element(:xpath, "preceding-sibling::*[1]")
  end

  def child
    find_elements(:xpath, "child::*")
  end

  def descendant
    find_elements(:xpath, "descendant::*")
  end

  def method_missing(method_name, *args)
    select_methods = Selenium::WebDriver::Support::Select.instance_methods - Object.methods
    if select_methods.include?(method_name.to_sym)
      Selenium::WebDriver::Support::Select.new(self).send(method_name.to_sym, *args)
    end
  end
end
