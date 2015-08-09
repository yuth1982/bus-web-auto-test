require 'net/https'
module SSHTDSGrowQuota

  # Public: Connect to the tds and "Dump serialized manifest from tds or something like that"
  #
  # @username [String] 'qa1+andrea+fisher+1417@decho.com'
  # @password [String] 'test1234'
  # @machine_id [String] '4903844'
  # @i [Int] '1' iteration of method
  #
  # Example
  #  SSHTDSGrowQuota.grow_quota('qa1+andrea+fisher+1417@decho.com', 'test1234', '4903844', '1')
  #
  # @return [String] "Partner 12345 is using autogrow and is overdrafted on its Generic license by 5 GB"
  def grow_quota(username, password, machine_id, i)
    #encrypted_file_size = "1000000008"
    encrypted_file_size = (("1073741824".to_i)*(i.to_i)).to_s
    object_id = "73aecc4d92453e5dacaa1eddf1df55487cfb50af"
    filename = "gig-ishfile#{rand(500)}#{i}.txt"

    Log.debug "#{QA_ENV['tds_host']}, #{username}, #{password}, #{machine_id}, #{filename}, #{object_id}, #{encrypted_file_size}"
    http_conn = http_connect(QA_ENV['tds_host'])
    url = "/namedObjects/#{machine_id}/#{uri_escape(filename)}"
    request = Net::HTTP::Put.new(url)
    request.basic_auth(username, password)
    request["X-Objectid"] = object_id
    request["X-Eventual-Content-Encoding"] = "x-ciphertext"
    request["X-Eventual-Content-Length"] = encrypted_file_size
    request["Content-Length"] = 0

    result = http_conn.start { |http| http.request(request) }
    Log.debug result
    return result
  end

  def http_connect (host, port = 80)
    http_connection = Net::HTTP.new(host, port)
    return http_connection
  end

  def uri_escape(string)
    string.gsub(/([^a-zA-Z0-9_.-]+)/n) do
      '%' + $1.unpack('H2' * $1.size).join('%').upcase
    end
  end
end



