module Email
  require 'gmail'
  require 'viewpoint'
  require 'gibberish'

  class Gmail
    include Singleton

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
        content = gmail.mailbox('[Gmail]/All Mail').emails(query)[-1].body
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

  class Outlook
    include Viewpoint::EWS
    include Singleton

    def initialize
      endpoint = CONFIGS['outlook']['endpoint']
      user = CONFIGS['outlook']['username']
      f = File.open(CONFIGS['outlook']['password'], 'r')
      encrypted = f.read
      f.close
      f = File.open(CONFIGS['rsa']['private_key'], 'r')
      private_key = f.read
      f.close
      cipher = Gibberish::RSA.new(private_key)
      pass = cipher.decrypt(encrypted)
      @client = Viewpoint::EWSClient.new endpoint, user, pass, server_version: SOAP::ExchangeWebService::VERSION_2007_SP1
      @inbox = @client.get_folder_by_name 'Inbox', :act_as => CONFIGS['outlook']['mailbox']
      @found = nil
    end

    def find_emails(query,_=nil)
      start = Time.now
      while Time.now - start < 90
        begin
          items = @inbox.todays_items
          items.find do |item|
            email = @client.get_item item.id
            case query[0].downcase
              when 'to'
                if email.to_recipients[0].email_address.eql? query[1]
                  @found = Array.[](email)
                  break
                end
              when 'body'
                matched = true
                content = email.body
                query_arr = eval query[1]
                query_arr.each do |q|
                  matched &&= !content.match(q).nil?
                end
                if matched
                  @found = Array.[](email)
                  break
                end
            end
          end
        rescue Exception => ex
          Log.debug ex
        ensure
          sleep 10
        end
        break if !@found.nil?
      end
      @found
    end

    def find_email_content(query, _=nil)
      content = nil
      find_emails query if @found.nil?
      content = @found[0].body if !@found.nil?
      content
    end
  end

  #@email = Gmail.new
  #@emailxxx = Outlook.new #if MAILBOX.eql? 'outlook'

  def create_user_email
    "#{CONFIGS['global']['email_prefix']}+#{Forgery(:basic).password(:at_least => 9, :at_most => 12)}@#{CONFIGS['global']['email_domain']}".downcase
  end

  def create_admin_email(first_name,last_name)
    "#{CONFIGS['global']['email_prefix']}+#{first_name}+#{last_name}+#{Time.now.strftime("%H%M")}@#{CONFIGS['global']['email_domain']}".downcase
  end

  def find_emails(query, _=nil)
    email = Gmail.instance
    email = Outlook.instance if MAILBOX.eql? 'outlook'
    email.find_emails(query)
  end

  def find_email_content(query, _=nil)
    email = Gmail.instance
    email = Outlook.instance if MAILBOX.eql? 'outlook'
    email.find_email_content(query)
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
