require 'net/scp'
module SSHHelper
  PROXY_HOST = 'authproxy01.qa5.mozyops.com'
  SOCKD_CONF = '/etc/sockd.conf'
  #BUS_HOST = QA_ENV['bus_host'].gsub("https://", '')
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

  def ssh_phoenix(cmd)
    host = QA_ENV['phoenix01_host']
    user, password = QA_ENV['ssh_login'], QA_ENV['ssh_password']
    Net::SSH.start(host, user , :password => password ) {|ssh|  ssh.exec!(cmd)}
  end

  def ssh_bus(cmd)
    host = QA_ENV['client_host']
    user, password = QA_ENV['ssh_login'], QA_ENV['ssh_password']
    Net::SSH.start(host, user , :password => password ) {|ssh|  ssh.exec!(cmd)}
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

module SSHReap

  def enable_cybersoure_payment_force_failure
    #This makes mozyhome payments fail
    cmd = 'cd /etc'
    cmd += '; touch cybersource_payment_force_failure'
    cmd += '; /etc/init.d/apache2 restart'
    ssh_phoenix(cmd)
  end

  def disable_cybersoure_payment_force_failure
    #This makes mozyhome payments work again
    cmd = 'cd /etc'
    cmd += '; rm cybersource_payment_force_failure'
    cmd += '; /etc/init.d/apache2 restart'
    ssh_phoenix(cmd)
  end

  def run_phoenix_process_subscription_script(user_id)
    cmd = 'cd /var/www/phoenix'
    cmd += "; script/process_subscriptions -e production -u #{user_id}"
    ssh_phoenix(cmd)
  end

  def change_reap_yml_file(user_id,days_ago)

    fail('Reaps needs a User ID') if user_id.nil?

    #Get reap.yml from server
    cmd = 'cd /var/www/bus/config/'
    cmd += '; cat reap.yml'
    reap_yml = ssh_bus(cmd)

    #Edit reap.yml
    edited_yml = ''
    reap_yml.each_line do |line|
      if line.include? 'user_ids:'
        line = line.gsub('[',']').split(']')
        line = "#{line[0]}[#{user_id}]#{line[2]}"
      elsif line.include? 'reap_restart_date:'
        line = "#{line.split(/'/)[0]} '#{Date.today - days_ago}'\n"
      end
      edited_yml += line
    end

    #Update reap.yml on server
    cmd = 'cd /var/www/bus/config/'
    cmd += "; echo \"#{edited_yml}\" > reap.yml"
    ssh_bus(cmd)
  end

  def start_reap
    cmd = 'cd /var/www/bus'
    cmd += '; script/reap -v -f -e production mozy_home_delinquent'
    ssh_bus(cmd)
  end

end

