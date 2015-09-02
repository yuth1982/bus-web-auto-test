module Bus
  # This class provides actions for edit client version section
  class DownloadClientSection < SiteHelper::Section

    # Private elements
    #

    # Public: check whether the download link present for given link text in download * client section
    #
    def download_link_present?(link_name)
      !(locate(:xpath, "//a[contains(text(),'#{link_name}')]").nil?)
    end

    # Public: get client download info under Windows,Mac,Linux for given type (Backup/Sync Clients)
    #
    def client_download_info_hash(type)
      client_type_ele = all(:xpath,"//div[preceding-sibling::h3[1][text()='#{type}']]") 
      download_info_hashes = {}
      platform = ''
      client_type_ele.each { |ele|
        if ['Windows','Mac','Linux'].include?(ele.text)
          platform = ele.text
          download_info_hashes[platform] = ''
        else
          download_info_hashes[platform] += ele.text
        end
      }
      download_info_hashes
    end

    # Public: click download link which contains given string and returns client name of download item 
    #
    def click_link(link_name)
      if link_name.include?('Mac OS X 10.5 (Intel): ')
        download_link = find(:xpath, "//span[text()='Mac OS X 10.5 (Intel): ']").next_sibling
      else
        download_link = find(:xpath, "//a[contains(text(),'#{link_name}')]")
      end
      href = download_link.native.attribute 'href'
      download_link.click
      link_name.include?('vSphere')? href[/images\/.+$/].gsub('images/','') : href[/downloads\/.+$/].gsub('downloads/','')
    end

    # Public: click Details/Other Releases link of a given client
    #
    def open_view(link, client)
      find(:xpath, "//a[contains(text(),'#{client}')]//parent::div//a[text()='#{link}']").click
    end

    # check if client started downloading
    #
    def start_downloading?(client_name)
      file_name =  "#{default_download_path}/#{client_name}"
      i = 0
      15.times do
        break if ( File.size?(file_name).to_i + File.size?(file_name+'.part').to_i ) > 0
        sleep(1)
      end
      return (File.size?(file_name).to_i+File.size?(file_name+'.part').to_i) > 0
    end

  end

end

