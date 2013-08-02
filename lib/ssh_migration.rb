require 'net/ssh'
module SSHMigration

  HOST = QA_ENV['client_host']
  USER = QA_ENV['ssh_login']
  PASSWORD = QA_ENV['ssh_password']

# PUBLIC: Manual migration of partner to pooled storage
# 	in the future there will be a button in the partner
#	detail UI that will do the same thing as this script
  def migrate_to_pooled_storage(partner_id)

    Net::SSH.start(HOST, USER, :password => PASSWORD) do |session|
      succ_msg = "1 partners have been migrated successfully, 0 failed"
      script = "script/migrate_to_pooled_storage.rb -e production -p #{partner_id}"
      output = session.exec!("cd /var/www/bus && #{script}")

      log_dir = output.match(/log redirected to (\/root\/\d{4}\.\d{2}\.\d{2}\.\d{2}\.\d{2}\.\d{2}\.log\/\d+\.log)/)
      raise "Error: Cannot migrate partner: #{partner_id} to pooled storage.\n #{output}" if log_dir.nil?

      log_file = session.exec!("cat #{log_dir}")
      raise "Error: Cannot migrate partner: #{partner_id} to pooled storage.\n #{log_file}" if log_file.match(succ_msg).nil?
      end
  end

end