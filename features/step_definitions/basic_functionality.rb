
#Scenario: Go to register page

Given(/^I am on home page$/) do
  @browser.get 'http://demo.redmine.org'
end

When(/^I click "([^"]*)" link/) do |arg|
  @browser.find_element(class: arg).click
end

Then(/^I get to register page$/) do
  expect(@browser.current_url).to include ('register')
end

#Scenario Outline: User's registration

Given(/^I am on register page$/) do
  @browser.get 'http://demo.redmine.org/account/register'
end

And (/^I input (.*) to Login field$/) do |user_name|
  @browser.find_element(id: 'user_login').send_keys user_name
end

And(/^I input (.*) to Password field$/) do |password|
  @browser.find_element(id: 'user_password').send_keys password
end

And(/^I input (.*) to Confirmation field$/) do |confirmation|
  @browser.find_element(id: 'user_password_confirmation').send_keys confirmation
end

And(/^I input (.*) to First name field$/) do |first_name|
  @browser.find_element(id: 'user_firstname').send_keys first_name
end

And(/^I input (.*) to Last name field$/) do |last_name|
  @browser.find_element(id: 'user_lastname').send_keys last_name
end

And(/^I input (.*) to Email field$/) do |email|
  @browser.find_element(id: 'user_mail').send_keys email
end

When (/^I click Submit button$/) do
  @browser.find_element(name: 'commit').click
end

Then (/^I am registered$/) do
 expect(@browser.current_url).to include ('my')
end

#Scenario: Sign In

Given(/^I am on Sign In page$/) do
  @browser.get 'http://demo.redmine.org/login'
end

And(/^I enter (.*) to Login field$/) do |user_name|
  @browser.find_element(id: 'username').send_keys user_name
end

And(/^I enter (.*) to Password field$/) do |password|
  @browser.find_element(id: 'password').send_keys password
end

When(/^I click Login button$/) do
  @browser.find_element(name: 'login').click
end

Then(/^I am logged in as (.*)$/) do |user_name|
  expect(@browser.find_element(:xpath, "//div[@id='loggedas']/a[text()='#{user_name}']").text).to match(user_name)
end

# Scenario: Sign Out

Given(/^I am signed in as (.*), (.*)$/) do |user_name, password|
  @browser.get 'http://demo.redmine.org/login'
  @browser.find_element(id: 'username').send_keys user_name
  @browser.find_element(id: 'password').send_keys password
  @browser.find_element(name: 'login').click
end

When(/^I click Sign Out link$/) do
  @browser.find_element(class: 'logout').click
end

Then(/^I get to home page$/) do
  expect(@browser.find_element(class: 'register')).to be_truthy
end


#Scenario: Change password

When(/^I go to Change password page$/) do
  sleep 3
  @browser.find_element(:xpath, ".//*[@id='account']/ul/li[1]/a").click
  @browser.find_element(:xpath, ".//*[@id='content']/div[1]/a[2]").click
end

And(/^I enter (.*) to New password field$/) do |new_password|
  @browser.find_element(id: 'new_password').send_keys new_password
end

And(/^I enter (.*) to Confirmation field$/) do |new_password|
  @browser.find_element(id: 'new_password_confirmation').send_keys new_password
end

And(/^click Apply button$/) do
  @browser.find_element(name: 'commit').click
end

Then(/^I see message that my password is changed$/) do
  expect(@browser.find_element(id: 'flash_notice')).to be_truthy
end

