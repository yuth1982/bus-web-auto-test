require File.expand_path('../../lib/email_helper/email_helper', __FILE__)
require File.expand_path('../../test_sites/configs/configs_helper', __FILE__)

include Email
require 'logger'

Log = Logger.new(STDOUT)
Log.level = Logger::DEBUG

CONFIGS['outlook']['password'] = File.expand_path("../../#{CONFIGS['outlook']['password']}", __FILE__)
CONFIGS['rsa']['public_key'] = File.expand_path("../../#{CONFIGS['rsa']['public_key']}", __FILE__)
CONFIGS['rsa']['private_key'] = File.expand_path("../../#{CONFIGS['rsa']['private_key']}", __FILE__)

mailbox = Outlook.instance
begin
  response = mailbox.empty_folder
rescue Exception => ex
  Log.error ex.message
  Log.error ex.backtrace.inspect
end

Log.info 'Emails has been successfully deleted' if response