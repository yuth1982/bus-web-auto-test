=begin
var = "12345678"
puts var =~ /^[1-9]*[1-9][0-9]*$/

var1 = "0"
puts var1 =~ /^(-\d*|(0)?$/

var2 = "-358"
puts var2 =~ /^-[1-9]*[0-9]$/

var3 = "0"
puts var3 =~ /^(0|[1-9][0-9]*|-[1-9][0-9])$/
=end

var4 = "10.123"
puts var4 =~ /^-?([1-9]\d*\.\d*|0\.\d*[1-9]\d*|0?\.0+|0)$/

