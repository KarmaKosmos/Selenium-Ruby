Given(/^I am on home page$/) do
  @browser.get 'http://demo.redmine.org'
end

When(/^I click Register link$/) do
  @browser.find_element(class: 'register').click
end

Then(/^I get to register page$/) do
  expect(@browser.find_element(//*[@id='content']/h2)).to include ("Register")
end


