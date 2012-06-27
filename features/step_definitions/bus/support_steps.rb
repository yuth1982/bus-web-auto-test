
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

#Transform /^the given partner$/ do |step_arg|
#  Admin.new "",@partner.email,@partner.name,"test1234"
#end

#Transform /^the new partner$/ do |step_arg|
#  Admin.new "",@partner.email,@partner.name,"test1234"
#end

Transform /^the new partner email$/ do |step_arg|
  @partner.email
end

Transform /^MozyPro 250 GB Plan \(Monthly\) test partner$/ do |step_arg|
  Bus::Admin.new "302369","qa1+Anthony+Ward@mozy.com","Thoughtworks Company","test1234"
end

Transform /^MozyPro 50 GB Plan \(Yearly\) test partner$/ do |step_arg|
  Bus::Admin.new "272859","qa1+amanda+roberts@mozy.com","Amanda Roberts","test1234"
end

Transform /^MozyPro 100 GB Plan \(Biennially\) test partner$/ do |step_arg|
  Bus::Admin.new "272861","qa1+gerald+williamson@mozy.com","Gerald Williamson","test1234"
end

Transform /^MozyPro 250 GB Plan \(Yearly\) test partner$/ do |step_arg|
  Bus::Admin.new "272863","qa1+reg4@mozy.com","shipu","test1234"
end

