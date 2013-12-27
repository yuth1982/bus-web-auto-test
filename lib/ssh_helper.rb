require 'net/scp'
module SSHHelper
  PROXY_HOST = 'authproxy01.qa5.mozyops.com'
  SOCKD_CONF = '/etc/sockd.conf'
  BUS_HOST = QA_ENV['bus_host'].gsub("https://", '')
  USER = QA_ENV['ssh_login']
  PASSWORD = QA_ENV['ssh_password']

  # Public: get the file from a server
  #
  def download(remote_path, local_path)
    Net::SCP.start(PROXY_HOST, USER, :password => PASSWORD) do |scp|
      scp.download(remote_path, local_path)
    end
  end

  def get_password_config(partner_id, type)
    Net::SSH.start(BUS_HOST, USER, :password => PASSWORD) do |session|
      script = "ruby script/get_password_policy.rb -e production -p #{partner_id} -t #{type}"
      output = session.exec!("cd /var/www/bus && #{script}")
      result = Hash[*output.match(/#<PasswordPolicy (.+)>/)[1].split(/(,|:) /).delete_if{|d| d.match(/,|:/)}.map {|d|d.gsub('true', 't').gsub('false', 'f')}]
    end
  end
end

module SSHRecordOverdraft
  HOST = QA_ENV['client_host']
  USER = QA_ENV['ssh_login']
  PASSWORD = QA_ENV['ssh_password']

  # Public: Connect to bus client, run the record_overdraft script and return results
  #
  # @partner_id [String] '123456'
  #
  # Example
  #  SSHRecordOverdraft.record_overdraft('123456')
  #
  # @return [String] "Partner #{d{6}} is using autogrow and is overdrafted on its Generic license by #{.+} GB"
  def record_overdraft(partner_id)

    Net::SSH.start(HOST, USER, :password => PASSWORD) do |session|
      script = "script/record_overdrafts -e production -p #{partner_id}"
      output = session.exec!("cd /var/www/bus && #{script}")
      output = output.scan(/Partner (\d{6}) is using autogrow and is overdrafted on its Generic license by (\d+) GB/)
      output = "Partner #{output[0][0].to_s} is using autogrow and is overdrafted on its Generic license by #{output[0][1].to_s} GB"
    end
  end
end
