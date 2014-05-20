module Email
  require 'gmail'

  def create_user_email
    "#{CONFIGS['global']['email_prefix']}+#{Forgery(:basic).password(:at_least => 9, :at_most => 12)}@#{CONFIGS['global']['email_domain']}".downcase
  end

  def create_admin_email(first_name,last_name)
    "#{CONFIGS['global']['email_prefix']}+#{first_name}+#{last_name}+#{Time.now.strftime("%H%M")}@#{CONFIGS['global']['email_domain']}".downcase
  end

  def find_emails(query,_=nil)
    found = nil
    Gmail.new(CONFIGS['gmail']['username'],CONFIGS['gmail']['password']) do |gmail|
      found = gmail.mailbox('[Gmail]/All Mail').emails(query)
    end  #Returning after so the connection is closed properly
    found
  end

  def find_email_content(query,_=nil)
    content = nil
    Gmail.new(CONFIGS['gmail']['username'],CONFIGS['gmail']['password']) do |gmail|
      content = gmail.mailbox('[Gmail]/All Mail').emails(query)[0].body
    end
    content
  end

  def count_licenses_from_email(email_body)
    #pu = past unactived, d = desktop, s = server, u = unactivated, a = activated
    pu,du,da,su,sa = false,0,0,0,0
    email_body.to_s.each_line do |line|
      pu = true if line.include?("<span class='label'>Activated</span></div>")
      if line.include?("</td><td>Desktop</td></tr>")
        (pu ? da += line.scan('Desktop').length : du += line.scan('Desktop').length )
      elsif line.include?("</td><td>Server</td></tr>")
        (pu ? sa += line.scan('Server').length : su += line.scan('Server').length )
      end
    end
    #puts "du:#{du} su:#{su} da:#{da} sa:#{sa} pu:#{pu}"
    return [du,su,da,sa]
  end

end
