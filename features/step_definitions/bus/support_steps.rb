
# login steps support

Transform /^administrator$/ do |step_arg|
  Bus::Admin.new "328342","shipuy@mozy.com","Shipu Yao","test1234"
end

Transform /^Shawn Cole admin$/ do |step_arg|
  Bus::Admin.new "331463","qa1+shawn+cole@mozy.com","Shawn Cole","test1234"
end

#Polly Kuhn
# Italy vat
Transform /^Schamberger-Cole admin$/ do |step_arg|
  Admin.new "272312","qa1+Kacie+Jacobson@mozy.com","Schamberger-Cole","test1234"
end

Transform /^the new partner email$/ do |step_arg|
  @partner.email
end