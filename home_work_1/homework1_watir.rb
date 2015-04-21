require 'watir-webdriver'

@browser = Watir::Browser.new :firefox
@browser.goto 'http://demo.redmine.org'


#sleep 2
def open_register_page
  @browser.link(class: 'register').click
end

def register_as(name, password)
  sleep 3
  @browser.text_field(id: 'user_login').set name
  @browser.text_field(id: 'user_password').set password
  @browser.text_field(id: 'user_password_confirmation').set password
  @browser.text_field(id: 'user_firstname').set name + 'John'
  @browser.text_field(id: 'user_lastname').set 'Smith'
  @browser.text_field(id: 'user_mail').set name + '@exmpl.com'
  @browser.button(name: 'commit').click
  fail 'Test is failed' unless @browser.div(id: 'flash_notice').text == 'Your account has been activated. You can now log in.'
end


def sign_out
  sleep 2
  @browser.link(class: 'logout').click
  #fail 'Your are still signed in' unless @browser.find_element(class: 'login').text == 'Register'
end

def sing_in_as(name, password)
  @browser.link(class: 'login').click
  @browser.text_field(id: 'username').set name
  @browser.text_field(id: 'password').set password
  @browser.button(name: 'login').click
  #fail 'Your are still signed out' unless @browser.find_element(class: 'my-account').text == 'My account'
end

def change_password(password, new_password)
  @browser.link(:xpath, ".//*[@id='account']/ul/li[1]/a").click
  sleep 3
  @browser.link(:css, ".icon.icon-passwd").click
  @browser.text_field(id: 'password').set password
  @browser.text_field(id: 'new_password').set new_password
  @browser.text_field(id: 'new_password_confirmation').set new_password
  @browser.button(name: 'commit').click
  fail 'Test is failed' unless @browser.div(id: 'flash_notice').text == 'Password was successfully updated.'
end

def create_project(project_name, project_identifier)
  @browser.link(class: 'projects').click
  sleep 3
  @browser.link(:css, ".icon.icon-add").click
  @browser.text_field(id: 'project_name').set project_name
  @browser.text_field(id: 'project_identifier').set project_identifier
  @browser.button(name: 'commit').click
  fail 'Test is failed' unless @browser.text.include? 'Successful creation.'
end

def add_member(member_name)
  #@browser.find_element(class: 'settings').click
  sleep 2
  @browser.link(:css, '.user.active').click
  @browser.link(:xpath, "//*[@id='content']//ul[2]/li/a").click
  @browser.link(:css, ".settings").click
  sleep 3
  @browser.link(:xpath, ".//*[@id='tab-members']").click
  @browser.link(:css, ".icon.icon-add").click
  @browser.text_field(id: 'principal_search').set member_name
  sleep 5
  @browser.checkbox(name: 'membership[user_ids][]').click
  @browser.checkbox(:xpath, ".//*[@id='new_membership']/fieldset[2]/div/label[3]/input").click
  @browser.button(id: 'member-add-submit').click
end

  def edit_user_role
    sleep 3
    edit = @browser.link(:link, "Edit")
    sleep 3
    edit.each do |e|
      e.click
      @browser.checkbox(:xpath, "//p/label[2]/input").click
      sleep 3
      @browser.button(:xpath, "//td[2]/form/p[2]/input").click
    end
  end

  #Не могу определить корректный локатор

  def create_project_version(version_name)
    sleep 3
    @browser.link(id: 'tab-versions').click
    @browser.link(:xpath,  ".//*[@id='tab-content-versions']/p[2]/a").click
    @browser.text_field(id: 'version_name').set version_name
    @browser.button(name: 'commit').click
    fail 'Test is failed' unless @browser.text.include? 'Successful creation.'
  end

  def go_to_issues_page
    @browser.link(class: 'issues').click
  end

  def go_to_issue_adding_page
    @browser.link(class: 'new-issue').click
  end

  def add_bug(bug_name)
    @browser.select_list(id: 'issue_tracker_id').option(:text => 'Bug').select
    @browser.text_field(id: 'issue_subject').set bug_name
    @browser.text_field(id: 'issue_description').set 'test'
    @browser.select_list(id: 'issue_assigned_to_id').option(:text => 'John Doe')
    @browser.button(name: 'commit').click
    #fail 'Test is failed' unless @browser.find_element(id: 'flash_notice').text == 'Issue'+'created.'
  end

  def add_feature(feature_name)
    sleep 3
    @browser.select_list(id: 'issue_tracker_id').option(:value, '2').select
    @browser.text_field(id: 'issue_subject').set feature_name
    @browser.text_field(id: 'issue_description').set 'test'
    @browser.select_list(id: 'issue_assigned_to_id').option(:text => 'John Doe')
    @browser.button(name: 'commit').click
    #fail 'Test is failed' unless @browser.find_element(id: 'flash_notice').text == 'Issue'+'created.'
  end

  def add_support_ticket(support_ticket_name)
    sleep 3
    @browser.select_list(id: 'issue_tracker_id').option(:value, '3').select
    sleep 2
    @browser.text_field(id: 'issue_subject').set support_ticket_name
    @browser.text_field(id: 'issue_description').set 'test'
    @browser.select_list(id: 'issue_assigned_to_id').option(:text => 'John Doe')
    @browser.button(name: 'commit').click
    #fail 'Test is failed' unless @browser.find_element(id: 'flash_notice').text == 'Issue'+'created.'
  end

  def displaying_bug_on_issues_page(bug_name)
    fail 'Test is failed' unless @browser.text.include? bug_name
  end

  def displaying_feature(feature_name)
    fail 'Test is failed' unless @browser.text.include? feature_name
  end

  def displaying_support_ticket(support_ticket_name)
    fail 'Test is failed' unless @browser.text.include? support_ticket_name
  end

  open_register_page
  register_as('bull19', '112233')

  sign_out
  open_register_page
  register_as('bull20', '112233')
  sign_out
  sing_in_as('bull19', '112233')
  change_password('112233', '223344')
  create_project('Kuku', 'kuku4')
  add_member('bull20')
  #edit_user_role
  create_project_version('Arjuna1')
  go_to_issue_adding_page
  add_bug('Buga #2')
  go_to_issue_adding_page
  add_feature('Feature #1')
  go_to_issue_adding_page
  add_support_ticket("Help #1")
  go_to_issues_page
  displaying_bug_on_issues_page('Buga #2')
  displaying_feature('Feature #1')
  displaying_support_ticket("Help #1")

