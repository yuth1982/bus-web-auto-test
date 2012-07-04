
# login steps support

Transform /^administrator$/ do |step_arg|
  Bus::Admin.new "328342","shipuy@mozy.com","Shipu Yao","test1234"
end

Transform /^test account$/ do |step_arg|
  # Account created on July 3rd
  Bus::Admin.new "380438","qa1+robin+perkins@mozy.com","Shawn Cole","test1234"
end

Transform /^the new partner email$/ do |step_arg|
  @partner.email
end