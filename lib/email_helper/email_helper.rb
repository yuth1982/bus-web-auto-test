module Email
  require 'gmail'
  require 'viewpoint'
  require 'gibberish'

  class GmailBox
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
      @found = nil
      start = Time.now
      while Time.now - start < 90
        begin
          ten_minutes_ago = Time.now - 10*60
          items = @inbox.items_since(DateTime.parse(ten_minutes_ago.to_s))
          items.find do |item|
            email = @client.get_item item.id
            query.each_index {|index| query[index]=query[index].downcase if index%2 == 0}

            to_match = from_match = content_match = subject_match = true

            to_match = false if query.include?('to') && !(email.to_recipients[0].email_address.eql? query[query.index('to')+1])
            next if !to_match

            from_match = false if query.include?('from') && !(email.from.email_address.eql? query[query.index('from')+1])
            next if !from_match

            subject_match = false if query.include?('subject') && !(email.subject.eql? query[query.index('subject')+1])
            next if !subject_match

            if query.include?('body')
              content = email.body
              body_pattern = query[query.index('body')+1]
              if body_pattern.include?('@') || body_pattern.include?(' ') # if the search pattern is email address or full name
                content_match &&= !content.match(body_pattern.gsub('+','\\\+')).nil?
              else                           # else the search patter should be license key array
                query_arr = eval body_pattern
                query_arr.each do |q|
                  content_match &&= !content.match(q).nil?
                end
              end
            end
            next if !content_match

            @found = Array.[](email)

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

  def get_email_prefix
    if RUBY_PLATFORM.include?('linux')
      CONFIGS['global']['email_prefix'] = CONFIGS['global']['email_prefix_gmail']
    else
      CONFIGS['global']['email_prefix'] = CONFIGS['global']['email_prefix_outlook']
    end
  end

  def get_email_domain
    if RUBY_PLATFORM.include?('linux')
      CONFIGS['global']['email_domain'] = CONFIGS['global']['email_domain_gmail']
    else
      CONFIGS['global']['email_domain'] = CONFIGS['global']['email_domain_outlook']
    end
  end

  def create_user_email
    "#{get_email_prefix}+#{Forgery(:basic).password(:at_least => 9, :at_most => 12)}@#{get_email_domain}".downcase
  end

  def create_admin_email(first_name,last_name)
    "#{get_email_prefix}+#{first_name}+#{last_name}+#{Time.now.strftime("%H%M")}@#{get_email_domain}".downcase
  end

  def find_emails(query, _=nil)
    email = GmailBox.instance
    email = Outlook.instance unless RUBY_PLATFORM.include?('linux')
    email.find_emails(query)
  end

  def find_email_content(query, _=nil)
    email = GmailBox.instance
    email = Outlook.instance unless RUBY_PLATFORM.include?('linux')
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
