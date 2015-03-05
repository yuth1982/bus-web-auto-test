module Email
  require 'mailgun'

  def create_user_email
    "#{CONFIGS['global']['email_prefix']}+#{Forgery(:basic).password(:at_least => 9, :at_most => 12)}@#{CONFIGS['global']['email_domain']}".downcase
  end

  def create_admin_email(first_name,last_name)
    "#{CONFIGS['global']['email_prefix']}+#{first_name}+#{last_name}+#{Time.now.strftime("%H%M")}@#{CONFIGS['global']['email_domain']}".downcase
  end

  def find_emails(query,_=nil)
    found = nil
    start = Time.now
    mg_client = Mailgun::Client.new CONFIGS['mailgun']['api_key']
    domain = CONFIGS['mailgun']['domain']
    while Time.now - start < 90
      begin
        results = mg_client.get("#{domain}/events", :event => 'stored', :limit => 10).to_h
        results['items'].each do |item|
          case query[0].downcase
            when 'to'
              if item['message']['headers'][query[0].downcase].eql? query[1]
                found = Array.[](item)
                @mailKey = item['storage']['key']
                break
              end
            when 'body'
              matched = true
              @mailKey = item['storage']['key']
              content = find_email_content nil
              strArr = eval query[1]
              strArr.each do |q|
                matched &&= !content.match(q).nil?
              end
              if matched
                found = Array.[](item)
                break
              end
          end
        end
      rescue Exception => ex
          Log.debug ex
      ensure
        sleep 5
      end
      break if !found.nil?
    end
    found
  end

  def find_email_content(query,_=nil)
    find_emails query if @mailKey.nil?

    mg_client = Mailgun::Client.new CONFIGS['mailgun']['api_key']
    domain = CONFIGS['mailgun']['domain']
    result = mg_client.get("domains/#{domain}/messages/#{@mailKey}").to_h
    result['body-plain']
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
