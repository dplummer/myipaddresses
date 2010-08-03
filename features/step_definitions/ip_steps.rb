Given /^the following IP addresses:$/ do |table|
  table.hashes.each do |ip|
    if ip['type'] == 'Ipv4'
      Ipv4.create(ip)
    elsif ip['type'] == 'Ipv6'
      Ipv6.create(ip)
    end
  end
end

When /^I list IP addresses$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should list the IPv[4|6] address ([\dA-Fa-f\.:]+)[\/]?(\d{0,3})$/ do |address, prefix|
  puts address
  puts prefix
  pending # express the regexp above with the code you wish you had
end
