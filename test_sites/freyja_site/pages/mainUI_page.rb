module Freyja
  class MainUI < SiteHelper::Page

    element(:machine, css: "span.check.plus")
    #element(:machine, css: "#dt-backuplist")
    element(:backupDevice, css: "a[onclick*=ACCESS_CONTROLLER_BACKUP]")
    element(:syncDevice, css: "a[onclick*=ACCESS_CONTROLLER_SYNC]")

    def chooseMachine
      wait_until do
        machine.visible?
      end
      machine.click
    end

    def chooseBackupDevice
      wait_until do
        backupDevice.visible?
      end
      backupDevice.click
    end

    def chooseSyncDevice
      wait_until do
        syncDevice.visible?
      end
      syncDevice.click
    end

  end
end