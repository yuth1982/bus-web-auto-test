require 'net/scp'
module SSHHelper
  PROXY_HOST = 'authproxy01.qa5.mozyops.com'
  USER = 'root'
  PASSWORD = 'QAP@SSw0rd'
  SOCKD_CONF = '/etc/sockd.conf'

  # Public: get the file from a server
  #
  def download(remote_path, local_path)
    Net::SCP.start(PROXY_HOST, USER, :password => PASSWORD) do |scp|
      scp.download(remote_path, local_path)
    end
  end
end