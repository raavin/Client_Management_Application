Given /^the following services:$/ do |services|
  Service.create!(services.hashes)
end

Given /^I am logged in as "([^"]*)" with password "([^"]*)"$/ do |user_email, user_password|
  visit new_user_session_path
  fill_in "user_email", :with => "jason@skys.org.au" 
  fill_in "user_password", :with => "testor"
  click_button "Login" 
end

When /^I delete the (\d+)(?:st|nd|rd|th) service$/ do |pos|
  visit services_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following services:$/ do |expected_services_table|
  expected_services_table.diff!(tableish('table tr', 'td,th'))
end
