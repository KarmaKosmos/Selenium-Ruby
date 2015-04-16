require 'selenium-webdriver'
require_relative 'helpers'

@browser = Selenium::WebDriver.for :firefox
@browser.manage.timeouts.implicit_wait = 30
@browser.get 'http://demo.redmine.org'


include Helpers::GoToPage
include Helpers::Validate

#sleep 2
#def open_register_page
  #@browser.find_element(class: 'register').click
#end

def register_as(name, password)
  @browser.find_element(id: 'user_login').send_keys name
  @browser.find_element(id: 'user_password').send_keys password
  @browser.find_element(id: 'user_password_confirmation').send_keys password
  @browser.find_element(id: 'user_firstname').send_keys 'John'
  @browser.find_element(id: 'user_lastname').send_keys 'Smith'
  @browser.find_element(id: 'user_mail').send_keys 'exmpl85@exmpl.com'
  @browser.find_element(name: 'commit').click
  fail 'Test is failed' unless @browser.find_element(id: 'flash_notice').text == 'Your account has been activated. You can now log in.'
end


def sign_out
  @browser.find_element(class: 'logout').click
  #fail 'Your are still signed in' unless @browser.find_element(class: 'login').text == 'Register'
end

def sing_in_as(name, password)
  @browser.find_element(class: 'login').click
  @browser.find_element(id: 'username').send_keys name
  @browser.find_element(id: 'password').send_keys password
  @browser.find_element(name: 'login').click
  #fail 'Your are still signed out' unless @browser.find_element(class: 'my-account').text == 'My account'
end

def change_password(password, new_password)
  @browser.find_element(:xpath, ".//*[@id='account']/ul/li[1]/a").click
  sleep 3
  @browser.find_element(:css, ".icon.icon-passwd").click
  @browser.find_element(id: 'password').send_keys password
  @browser.find_element(id: 'new_password').send_keys new_password
  @browser.find_element(id: 'new_password_confirmation').send_keys new_password
  @browser.find_element(name: 'commit').click
end

def checking_flash_for_pswd
  fail 'Test is failed' unless @browser.find_element(id: 'flash_notice').text == 'Password was successfully updated.'
end

def create_project(project_name, project_identifier)
  @browser.find_element(class: 'projects').click
  sleep 3
  @browser.find_element(:css, ".icon.icon-add").click
  @browser.find_element(id: 'project_name').send_keys project_name
  @browser.find_element(id: 'project_identifier').send_keys project_identifier
  @browser.find_element(name: 'commit').click
end

def checking_flash_for_project
  fail 'Test is failed' unless @browser.find_element(id: 'flash_notice').text == 'Successful creation.'
end

def add_member(member_name)
  #@browser.find_element(class: 'settings').click
  sleep 3
  @browser.find_element(:xpath, ".//*[@id='tab-members']").click
  @browser.find_element(:css, ".icon.icon-add").click
  @browser.find_element(id: 'principal_search').send_keys member_name
  sleep 5
  @browser.find_element(name: 'membership[user_ids][]').click
  @browser.find_element(:xpath, ".//*[@id='new_membership']/fieldset[2]/div/label[3]/input").click
  @browser.find_element(id: 'member-add-submit').click
end

name_array = ['John Smith', 'John Doe']

name_array.each do |name|
  @browser.find_elements(:xpath, "//a[text()=#{name}]/ancestor::td[@class='name user']/following-sibling::td[@class='buttons']/a[@class='icon icon-edit']").click
  @browser.find_element(:xpath, "//a[text()=#{name}]/ancestor::td[@class='name user']/following-sibling::td[@class='roles']//p[1]//input[@value=4]").click
  @browser.find_element(:xpath, "//a[text()=#{name}]/ancestor::td[@class='name user']/following-sibling::td[@class='roles']//p[2]/input[@name='commit']").click
end

def edit_user_role(name_array)
  sleep 3
  #edit = @browser.find_elements(:link, "Edit")
  edit = @browser.find_elements(:xpath, "//a[text()=#{name_array}]/ancestor::td[@class='name user']/following-sibling::td[@class='buttons']/a[@class='icon icon-edit']")
  sleep 3
  edit.each do |e|
    e.click
    @browser.find_element(:xpath, "//p/label[2]/input").click
    sleep 3
    #@browser.find_element(:xpath, "//td[2]/form/p[2]/input").click
    @browser.find_element(:css, "input.small").click
  end

  #Не могу определить корректный локатор

end

def create_project_version(version_name)
  sleep 3
  @browser.find_element(id: 'tab-versions').click
  @browser.find_element(:xpath,  ".//*[@id='tab-content-versions']/p[2]/a").click
  @browser.find_element(id: 'version_name').send_keys version_name
  @browser.find_element(name: 'commit').click
  fail 'Test is failed' unless @browser.find_element(id: 'flash_notice').text == 'Successful creation.'
end

def go_to_issues_page
  @browser.find_element(class: 'issues').click
end

def go_to_issue_adding_page
  @browser.find_element(class: 'new-issue').click
end

def add_bug(bug_name)
  option = Selenium::WebDriver::Support::Select.new(@browser.find_element(id: 'issue_tracker_id'))
  option.first_selected_option
  @browser.find_element(id: 'issue_subject').send_keys bug_name
  @browser.find_element(id: 'issue_description').send_keys 'test'
  assignee = Selenium::WebDriver::Support::Select.new(@browser.find_element(id: 'issue_assigned_to_id'))
  assignee.select_by(:text, 'John Doe')
  @browser.find_element(name: 'commit').click
  #fail 'Test is failed' unless @browser.find_element(id: 'flash_notice').text == 'Issue'+'created.'
end

def add_feature(feature_name)
  sleep 3
  option = Selenium::WebDriver::Support::Select.new(@browser.find_element(id: 'issue_tracker_id'))
  option.select_by(:value, '2')
  sleep 3
  @browser.find_element(id: 'issue_subject').send_keys feature_name
  @browser.find_element(id: 'issue_description').send_keys 'test'
  assignee = Selenium::WebDriver::Support::Select.new(@browser.find_element(id: 'issue_assigned_to_id'))
  assignee.select_by(:text, 'John Doe')
  @browser.find_element(name: 'commit').click
  #fail 'Test is failed' unless @browser.find_element(id: 'flash_notice').text == 'Issue'+'created.'
end

def add_support_ticket(support_ticket_name)
  sleep 3
  option = Selenium::WebDriver::Support::Select.new(@browser.find_element(id: 'issue_tracker_id'))
  option.select_by(:value, '3')
  sleep 3
  @browser.find_element(id: 'issue_subject').send_keys support_ticket_name
  @browser.find_element(id: 'issue_description').send_keys 'test'
  assignee = Selenium::WebDriver::Support::Select.new(@browser.find_element(id: 'issue_assigned_to_id'))
  assignee.select_by(:text, 'John Doe')
  @browser.find_element(name: 'commit').click
  #fail 'Test is failed' unless @browser.find_element(id: 'flash_notice').text == 'Issue'+'created.'
end

def displaying_bug_on_issues_page(bug_name)
  fail 'Test is failed' unless @browser.find_element(link: bug_name).text == bug_name
end

def displaying_feature(feature_name)
  fail 'Test is failed' unless @browser.find_element(link: feature_name).text == feature_name
end

def displaying_support_ticket(support_ticket_name)
  fail 'Test is failed' unless @browser.find_element(link: support_ticket_name).text == support_ticket_name
end

open_register_page
#register_as('troll85', '112233')
#sign_out
#sing_in_as('troll40', '112233')
#change_password('112233', '223344')
#create_project('OOP', '59')
#add_member('troll9')
#edit_user_role
#create_project_version('Arjuna1')
#go_to_issue_adding_page
#add_bug('Buga #2')
#go_to_issue_adding_page
#add_feature('Feature #1')
#go_to_issue_adding_page
#add_support_ticket("Help #1")
#go_to_issues_page
#displaying_bug_on_issues_page('Buga #2')
#displaying_feature('Feature #1')
#displaying_support_ticket("Help #1")