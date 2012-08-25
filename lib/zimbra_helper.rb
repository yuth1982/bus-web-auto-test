module Zimbra
  module Inbox

    def find_email(id, format="xml")
      raise "Not implemented"
    end

    def find_emails(query, format="xml")
      response = RestClient.get(
          "#{Zimbra::ZM_HOST}/zimbra/home/#{Zimbra::ZM_USER}/inbox?fmt=#{format}&query=#{query.gsub(" ","%20")}&auth=qp&zauthtoken=#{auth_token}"
      )
      parse_email_obj(response.body)
    end

    private

    # Private: Get auth token
    #
    def auth_token
      RestClient.post(
          Zimbra::ZM_HOST,
          { :loginOp => 'login',:username => Zimbra::ZM_USER, :password => Zimbra::ZM_PWD, :client => 'preferred' },
          { :cookies => { :ZM_TEST => "true" } }
      ){ |response, request, result, &block|
        if [301, 302, 307].include? response.code
          response.follow_redirection(request, result, &block)
          return response.headers[:set_cookie][0].match(/ZM_AUTH_TOKEN=([^;]+)/)[1]
        else
          response.return!(request, result, &block)
        end
      }
    end

    # Private: Parse zimbra mail xml to object
    #
    # Example:
    #
    #   Source xml:
    #   <m id=\"64738\" f=\"u\" rev=\"72148\" d=\"1345542459000\" s=\"2493\" l=\"2\" cid=\"64739\">
    #     <e d=\"redacted-3364\" t=\"f\" a=\"redacted-3364@notarealdomain.mozy.com\"/>
    #     <su>MozyPro License Keys Assigned for Data Shuttle</su>
    #     <fr>The following MozyPro license keys are assigned to users and the users have been notified. These keys are marked for use with the Data Shuttle ...</fr>
    #   </m>
    #
    def parse_email_obj(body_xml)
      xml_doc = Nokogiri::XML(body_xml)
      nodes = xml_doc.xpath("items/m")

      mails = []
      nodes.each do |node|
        mail = Struct.new(:id, :from, :subject, :fragment)
        mails << mail.new(node.attribute("id").text,node.xpath("./e").attribute("a").text,node.xpath("./su").text,node.xpath("./fr").text)
      end
      mails
    end

  end
end