module Utility
  def hash_to_object(hash, obj)
    hash.each do |k,v|
      obj.send("#{k}=", v)
    end
  end

  # added by leong
  def migrate_partners(start_pid, end_pid='')
    response = RestClient::Request.execute(:method => :get, :url => "#{TOOLS_ENV['migration_url']}?starting=#{start_pid}&ending=#{end_pid}", :timeout => 120, :open_timeout => 120)

    if end_pid.empty?
      num = 1
    else
      num = end_pid.to_i - start_pid.to_i
    end

    raise 'migrate partners error' unless response.to_s.include?("#{num} partners have been successfully migrated")
   end
end
