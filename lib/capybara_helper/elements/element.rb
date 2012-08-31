# Public: Add extension method to Element class
#
class Capybara::Node::Element
  include CapybaraHelper::Elements::CheckBox
  include CapybaraHelper::Elements::Table
  include CapybaraHelper::Elements::Select
  include CapybaraHelper::Elements::TextField
  include CapybaraHelper::Elements::Link

  # Public: element's id attribute value
  #
  # Returns a string of element's id attribute value

  def id
    self[:id]
  end

  # Public: element's name attribute value
  #
  # Returns a string of element's name attribute value
  def name
    self[:name]
  end

  # Public: clear value of an element
  # This might not work with webkit
  #
  def clear_value
    driver.evaluate_script("document.getElementById('#{self[:id]}').value=''")
  end

  # Public: Get parent element of current element
  #
  # Returns parent element of current element
  def element_parent
    find(:xpath, "..")  #parent::*[1]
  end

  # Public: Get next sibling element of current element
  #
  # Returns next sibling element of current element
  def next_sibling
    find(:xpath, "following-sibling::*[1]")
  end

  # Public: Get previous sibling element of current element
  #
  # Returns previous sibling element of current element
  def previous_sibling
    find(:xpath, "preceding-sibling::*[1]")
  end

  # Public: Get all child elements of current element
  #
  # Returns all child elements of current element
  def child
    all(:xpath, "child::*")
  end

  # Public: Get first child element of current element
  #
  # Returns first child element of current element
  def first_child
    find(:xpath, "child::*[1]")
  end

  # Public: Get descendant elements of current element
  #
  # Returns descendant elements of current element
  def descendant
    all(:xpath, "descendant::*")
  end
end
