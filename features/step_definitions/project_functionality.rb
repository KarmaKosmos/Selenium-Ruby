#Scenario Outline: Create project

And(/^I go to 'New project' page$/) do
  @browser.find_element(class: 'projects').click
  @browser.find_element(:css, ".icon.icon-add").click
end

And(/^I input project name (.*)$/) do |project_name|
  @browser.find_element(id: 'project_name').send_keys project_name
end

And(/^I input project identifier (.*)$/) do |project_identifier|
  @browser.find_element(id: 'project_identifier').send_keys project_identifier
end

When(/^I click 'Create' button$/) do
  sleep 3
  @browser.find_element(name: 'commit').click
end

Then(/^I see system message about successful creation$/) do
  sleep 2
  expect(@browser.find_element(id: 'flash_notice')).to be_truthy
end

#Scenario Outline: Create project version

And(/^I go to settings of (.*)/) do |project_name|
  sleep 3
  @browser.find_element(:xpath, ".//*[@id='loggedas']/a").click
  sleep 3
  @browser.find_element(:xpath, ".//*[@id='content']//a[text()='#{project_name}']").click
  @browser.find_element(:css, ".settings").click
end

And(/^I go to 'Versions' tab$/) do
  @browser.find_element(id: 'tab-versions').click
end

And(/^I go to 'New version' page$/) do
  @browser.find_element(:xpath, ".//*[@id='tab-content-versions']/p/a").click
end

And(/^I input new version name (.*)$/) do |version_name|
  @browser.find_element(id: 'version_name').send_keys version_name
end

# Scenario: Add member

And(/^I go to 'Members' tab$/) do
  sleep 2
  @browser.find_element(:xpath, ".//*[@id='tab-members']").click
end

And(/^I go to 'New member' modal$/) do
  @browser.find_element(:css, ".icon.icon-add").click
end

And(/^I search for (.*)$/) do |user_fullname|
  sleep 2
  @browser.find_element(id: 'principal_search').send_keys user_fullname
end

And(/^I click checkbox in front of found user$/) do
  sleep 2
  @browser.find_element(name: 'membership[user_ids][]').click
end

And(/^I define user's role$/) do
  @browser.find_element(:xpath, ".//*[@id='new_membership']/fieldset[2]/div/label[3]/input").click
end

When(/^I click 'Add' button$/) do
  @browser.find_element(id: 'member-add-submit').click
end

Then(/^(.*) appears in project's member list$/) do |user_fullname|
  sleep 2
  expect(@browser.find_element(:xpath,".//*[@id='tab-content-members']//td[@class='name user']/a[text()='#{user_fullname}']").text).to match(/#{user_fullname}/)
end

#Scenario Outline: Adding ticket

And(/^I am on project (.*) page$/) do |project_name|
  @browser.find_element(:css, '.user.active').click
  @browser.find_element(:xpath, ".//*[@id='content']//a[text()='#{project_name}']").click
end

And(/^I click 'New issue' tab$/) do
  @browser.find_element(class: 'new-issue').click
end

And(/^tracker is (.*)$/) do |tracker_value|
  option = Selenium::WebDriver::Support::Select.new(@browser.find_element(id: 'issue_tracker_id'))
  tickets = {"Bug" => '1', "Feature" => '2', "Support" => '3'}
  if tracker_value == 'Bug'
    option.first_selected_option
  else
    option.select_by(:value, tickets[tracker_value])
  end
end

And(/^subject is (.*)$/) do |ticket_name|
  sleep 2
  @browser.find_element(id: 'issue_subject').send_keys ticket_name
end

And(/^description is 'test'$/) do
  @browser.find_element(id: 'issue_description').send_keys 'test'
end

And(/^assignee is (.*)$/) do |user_fullname|
  sleep 3
  assignee = Selenium::WebDriver::Support::Select.new(@browser.find_element(id: 'issue_assigned_to_id'))
  assignee.select_by(:text, "#{user_fullname}")
end

#Scenario Outline: Checking of tickets' displaying on 'Issue' page

When(/^I am on 'Issue' page$/) do
  sleep 2
  @browser.find_element(:css, '.user.active').click
  @browser.find_element(:xpath, "//*[@id='content']//ul[2]/li/a").click
  @browser.find_element(class: 'issues').click
end

Then(/^I see (.*) in the list of tickets$/) do |ticket_name|
  sleep 2
  expect(@browser.find_element(link: ticket_name)).to be_truthy
end

#Scenario Outline: Edit user role

And(/^I am on 'Members' tab on 'Settings' page$/) do
  sleep 2
  @browser.find_element(:css, '.user.active').click
  @browser.find_element(:xpath, "//*[@id='content']//ul[2]/li/a").click
  sleep 2
  @browser.find_element(:css, ".settings").click
  @browser.find_element(:id, 'tab-members').click
end

When(/^I edit (.*)'s role adding (.*) and save it$/) do |user_fullname, new_role|
  roles = {"Manager" => 3, "Developer" => 4, "Reporter" => 5}
  @browser.find_element(:xpath, "//a[text()='#{user_fullname}']/ancestor::td[@class='name user']/following-sibling::td[@class='buttons']/a[@class='icon icon-edit']").click
  @browser.find_element(:xpath, "//a[text()='#{user_fullname}']/ancestor::td[@class='name user']/following-sibling::td[@class='roles']//p[1]//input[@value=#{roles[new_role]}]").click
  @browser.find_element(:xpath, "//a[text()='#{user_fullname}']/ancestor::td[@class='name user']/following-sibling::td[@class='roles']//p[2]/input[@name='commit']").click
end

Then(/^I see (.*) with (.*) role in users' list$/) do |user_fullname, new_role|
  expect(@browser.find_element(:xpath, "//a[text()='#{user_fullname}']/ancestor::td[@class='name user']/following-sibling::td[@class='roles']").text).to include(new_role)
end

