require 'singleton'

class SeleniumHelper
  include Singleton

  # @return [Array<String>]
  def get_elements_text elements
    elements_text = []
    elements.each {|ele| elements_text << ele.text.strip.gsub(/\n/,' ')}
    elements_text
  end

  def duplicate_element_id_validate html_source
    doc = Nokogiri::HTML(html_source)
    elements = doc.xpath("//*")
    id_list = {}
    for ele in elements
        id = ele["id"]
        if !id.nil? and !id.empty?
          id_list[id] = id_list[id] ? id_list[id] + 1 : 1
        end
      end
      for key in id_list.keys
        #puts key
        raise "Duplicate id: #{key}" if id_list[key] > 1
      end
  end

  def distance_to_id html_source
    nokogiri_selectors= ["select","textarea","form","input","div","a"]

    doc = Nokogiri::HTML(html_source)
    elements = doc.xpath("//*")
    puts elements.length
    for ele in elements
      current = ele
      distance = 0
      if nokogiri_selectors.include?(current.name)
          while (current.name != "body" and current["id"].nil?)
              current = current.parent
              distance = distance + 1
          end
          puts "parent: #{current.name}[id:#{current["id"]}] current:#{ele.name}[id:#{ele["id"]}] distance: #{distance}"
      end
    end
  end


end