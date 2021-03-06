
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))



Then /^I should be on ([^\"]*)$/ do |page_name|
  response.request.path.should == path_to(page_name)
end


And /^I am at Soul Food Farm/ do
  visit path_to('the farm "Soul Food Farm"')
end

Given /^there is a snippet titled "([^\"]*)"$/ do |title|
  snippet = Factory.create(:snippet, :title => title, :farm => @farm)
end

Then /^"([^"]*)" should be selected for "([^"]*)"$/ do |value, field|
  find_field(field).text.should =~ /#{value}/
end
