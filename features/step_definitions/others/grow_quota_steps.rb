When /^I upload ([0-9]*) GB of data to device$/ do |amount|
  @grow_quota_response = [] if @grow_quota_response.nil?
  amount.to_i.times do |i|
    @grow_quota_response[i] = SSHTDSGrowQuota.grow_quota(@new_users.first.email, CONFIGS['global']['test_pwd'], @machine_id, i)
  end
end

When /^I upload data to device(| by batch)$/ do |upload_type, grow_quota_table|
  attr = grow_quota_table.hashes.first
  attr.each do |_, v|
    v.replace ERB.new(v).result(binding)
  end

  user_email = @current_user[:email] || attr['user_name']
  machine_id = @machine_id || attr['machine_id']
  amount = attr['GB'] || 1
  @grow_quota_response = [] if @grow_quota_response.nil?

  if upload_type == ' by batch'
    @grow_quota_response[0] = SSHTDSGrowQuota.grow_quota(user_email, CONFIGS['global']['test_pwd'], machine_id, amount)
  else
    amount.to_i.times do |i|
      @grow_quota_response[i] = SSHTDSGrowQuota.grow_quota(user_email, CONFIGS['global']['test_pwd'], machine_id, '1')
    end
  end
end

When /^tds returns successful upload$/ do
  @grow_quota_response.last.code.should == '200'
end

When /^tds return message should be:$/ do |message|
  @grow_quota_response.last.body.should == message
end

