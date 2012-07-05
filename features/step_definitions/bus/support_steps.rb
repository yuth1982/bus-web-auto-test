
# login steps support

Transform /^administrator$/ do |step_arg|
  Bus::Admin.new "shipuy@mozy.com","Shipu Yao","test1234"
end

Transform /^test account$/ do |step_arg|
  # Account created on July 3rd
  Bus::Admin.new "qa1+robin+perkins@mozy.com","Shawn Cole","test1234"
end

Transform /^the new partner email$/ do |step_arg|
  @partner.email
end

Transform /^the new partner account$/ do |step_arg|
  Bus::Admin.new @partner.email,@partner.name,Bus::DEFAULT_PWD
end