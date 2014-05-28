module Freyja

  class MainPage < SiteHelper::Page

    element(:backupDevice, css: "a[onclick*=ACCESS_CONTROLLER_BACKUP]")
    element(:syncDevice, css: "a[onclick*=ACCESS_CONTROLLER_SYNC]")
    element(:action_panel_toggle, css: 'div.panel-toggle.btn-panel-toggle')
    element(:options_menu, css: 'span.text.username')
    element(:latest_version_radio, css: 'span.radio.radio-off')

    def choose_one_backup_device(machineID)
      find(:xpath, "//*[starts-with(@id,'#{machineID}:Folder:')][1]/td[1]/div/span").click
    end

    def chooseDevice(user)
      @deviceTab = user.deviceTab
      case @deviceTab
        when 'Devices'
          wait_until do
            backupDevice.visible?
          end
          backupDevice.click
        when 'Synced'
          wait_until do
            syncDevice.visible?
          end
          syncDevice.click
      end
    end

    def Drillin_sync_file(machineID, filePath)
      pathArray = filePath.split('/')
      pathLength = 0
      folderPath = ""
      (pathArray.size-1).times do
        if pathLength == 0
          folderPath = folderPath + pathArray[pathLength]
        else
          folderPath = folderPath + '/' + pathArray[pathLength]
        end
        find(:xpath, "//tr[@id='#{machineID}:Folder:/sync/1/#{folderPath}']/td[2]/div/span[2]/span").click
        sleep 2
        pathLength += 1
      end
      find(:xpath, "//tr[@id='#{machineID}:File:/sync/1/#{filePath}']/td/div/span").click
      sleep 2
    end

    def Drillin_sync_folder(machineID, folderPath)
      pathArray = folderPath.split('/')
      pathLength = 0
      folderPathList = ""
      (pathArray.size-1).times do
        if pathLength == 0
          folderPathList = folderPathList + pathArray[pathLength]
        else
          folderPathList = folderPathList + '/' + pathArray[pathLength]
        end
        find(:xpath, "//tr[@id='#{machineID}:Folder:/sync/1/#{folderPathList}']/td[2]/div/span[2]/span").click
        sleep 2
        pathLength += 1
      end
      find(:xpath, "//tr[@id='#{machineID}:Folder:/sync/1/#{folderPath}']/td/div/span").click
      sleep 2
    end

    def Drillin_win_backup_file(machineID, filePath)
      pathArray = filePath.split('\\')
      pathLength = 0
      folderPath = ""
      find(:xpath, "//tr[@id='#{machineID}:Folder:']/td[2]/div/span[2]/span").click
      (pathArray.size-1).times do
        if  pathLength == 0
          folderPath = folderPath + pathArray[pathLength]
        else
          folderPath = folderPath + '\\' + pathArray[pathLength]
        end
        find(:xpath, "//tr[@id='#{machineID}:Folder:#{folderPath}']/td[2]/div/span[2]/span").click
        sleep 2
        pathLength += 1
      end
      find(:xpath, "//tr[@id='#{machineID}:File:#{filePath}']/td/div/span").click
      sleep 2
    end

    def Drillin_win_backup_folder(machineID, folderPath)
      pathArray = folderPath.split('\\')
      pathLength = 0
      folderPathList = ""
      find(:xpath, "//tr[@id='#{machineID}:Folder:']/td[2]/div/span[2]/span").click
      (pathArray.size-1).times do
        if  pathLength == 0
          folderPathList = folderPathList + pathArray[pathLength]
        else
          folderPathList = folderPathList + '\\' + pathArray[pathLength]
        end
        find(:xpath, "//tr[@id='#{machineID}:Folder:#{folderPathList}']/td[2]/div/span[2]/span").click
        sleep 2
        pathLength += 1
      end
      find(:xpath, "//tr[@id='#{machineID}:Folder:#{folderPath}']/td/div/span").click
      sleep 2
    end

    def open_actions_panel
      action_panel_toggle.click
      sleep 3
    end

    def select_options_panel
      options_menu.click
      sleep 1
    end

    def select_uploaded_file(machine_id, file_name)
      find(:xpath, "//tr[@id='#{machine_id}:File:/sync/1/#{file_name}']/td/div/span").click
    end

    def select_latest_version
      latest_version_radio.click
    end


  end
end