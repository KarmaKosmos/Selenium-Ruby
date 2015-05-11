module Helpers

  module UserActions

    def declare
      @browser = Selenium::WebDriver.for :firefox
      @browser.manage.timeouts.implicit_wait = 30
      @browser.get 'http://demo.redmine.org'
    end

    def register_as(user)
      #@browser.find_element(class: 'register').click
      @browser.find_element(id: 'user_login').send_keys user.login
      @browser.find_element(id: 'user_password').send_keys user.password
      @browser.find_element(id: 'user_password_confirmation').send_keys user.password
      @browser.find_element(id: 'user_firstname').send_keys user.first_name
      @browser.find_element(id: 'user_lastname').send_keys user.last_name
      @browser.find_element(id: 'user_mail').send_keys user.email
      @browser.find_element(name: 'commit').click
    end

    def sing_in_as(user)
      @browser.find_element(class: 'login').click
      @browser.find_element(id: 'username').send_keys user.login
      @browser.find_element(id: 'password').send_keys user.password
      @browser.find_element(name: 'login').click
    end

    def sign_out
      @browser.find_element(class: 'logout').click
    end

    def change_password(user)
      @browser.find_element(:xpath, ".//*[@id='account']/ul/li[1]/a").click
      sleep 3
      @browser.find_element(:css, ".icon.icon-passwd").click
      @browser.find_element(id: 'password').send_keys user.password
      new_password = user.password + 44
      @browser.find_element(id: 'new_password').send_keys new_password
      @browser.find_element(id: 'new_password_confirmation').send_keys new_password
      @browser.find_element(name: 'commit').click
    end

    def edit_user_role(user)
      sleep 2
      @browser.find_element(:css, '.user.active').click
      @browser.find_element(:xpath, "//*[@id='content']//ul[2]/li/a").click
      sleep 2
      @browser.find_element(:css, ".settings").click
      @browser.find_element(:id, 'tab-members').click
      sleep 2
      @browser.find_element(:xpath, "//a[text()='#{user.full_name}']/ancestor::td[@class='name user']/following-sibling::td[@class='buttons']/a[@class='icon icon-edit']").click
      @browser.find_element(:xpath, "//a[text()='#{user.full_name}']/ancestor::td[@class='name user']/following-sibling::td[@class='roles']//p[1]//input[@value=4]").click
      @browser.find_element(:xpath, "//a[text()='#{user.full_name}']/ancestor::td[@class='name user']/following-sibling::td[@class='roles']//p[2]/input[@name='commit']").click
      sleep 2
    end
  end

  module ProjectActions

    def create_project(project_name, project_identifier)
      @browser.find_element(class: 'projects').click
      sleep 3
      @browser.find_element(:css, ".icon.icon-add").click
      @browser.find_element(id: 'project_name').send_keys project_name
      @browser.find_element(id: 'project_identifier').send_keys project_identifier
      @browser.find_element(name: 'commit').click
    end

    def create_project_version(version_name)
      sleep 3
      @browser.find_element(id: 'tab-versions').click
      @browser.find_element(:xpath,  ".//*[@id='tab-content-versions']/p[2]/a").click
      @browser.find_element(id: 'version_name').send_keys version_name
      @browser.find_element(name: 'commit').click
      fail 'Test is failed' unless @browser.find_element(id: 'flash_notice').text == 'Successful creation.'
    end

    def add_member(user)
      #@browser.find_element(class: 'settings').click
      sleep 2
      @browser.find_element(:css, '.user.active').click
      @browser.find_element(:xpath, "//*[@id='content']//ul[2]/li/a").click
      @browser.find_element(:css, ".settings").click
      sleep 3
      @browser.find_element(:xpath, ".//*[@id='tab-members']").click
      @browser.find_element(:css, ".icon.icon-add").click
      @browser.find_element(id: 'principal_search').send_keys user.full_name
      sleep 5
      @browser.find_element(name: 'membership[user_ids][]').click
      @browser.find_element(:xpath, ".//*[@id='new_membership']/fieldset[2]/div/label[3]/input").click
      @browser.find_element(id: 'member-add-submit').click
    end

    def add_issue(issues_hash, user)
      issues_hash.each do |value, ticket_name|
        sleep 3
        @browser.find_element(:css, '.user.active').click
        @browser.find_element(:xpath, "//*[@id='content']//ul[2]/li/a").click
        @browser.find_element(class: 'new-issue').click
        option = Selenium::WebDriver::Support::Select.new(@browser.find_element(id: 'issue_tracker_id'))
        if value == '1'
          option.first_selected_option
        else
          option.select_by(:value, value)
        end
        sleep 3
        @browser.find_element(id: 'issue_subject').send_keys ticket_name
        @browser.find_element(id: 'issue_description').send_keys 'test'
        assignee = Selenium::WebDriver::Support::Select.new(@browser.find_element(id: 'issue_assigned_to_id'))
        assignee.select_by(:text, "#{user.full_name}")
        @browser.find_element(name: 'commit').click
        sleep 3
      end
    end
  end

  module GoToPage
    def open_register_page
      @browser.find_element(class: 'register').click
    end

    def go_to_issues_page
      @browser.find_element(:css, '.user.active').click
      @browser.find_element(:xpath, "//*[@id='content']//ul[2]/li/a").click
      @browser.find_element(class: 'issues').click
    end
  end

  module Validate
    def successful_registration
      fail 'Test is failed' unless @browser.find_element(id: 'flash_notice').text == 'Your account has been activated. You can now log in.'
    end

    def checking_flash_for_pswd
      fail 'Test is failed' unless @browser.find_element(id: 'flash_notice').text == 'Password was successfully updated.'
    end

    def checking_flash_for_project
      fail 'Test is failed' unless @browser.find_element(id: 'flash_notice').text == 'Successful creation.'
    end

    def displaying_ticket(issues_hash)
      issues_hash.each_value do |value|
        fail 'Test is failed' unless @browser.find_element(link: value).displayed?
      end
    end
  end
end