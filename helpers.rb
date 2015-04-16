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

    def sing_in_as(login, password)
      @browser.find_element(class: 'login').click
      @browser.find_element(id: 'username').send_keys login
      @browser.find_element(id: 'password').send_keys @password
      @browser.find_element(name: 'login').click
    end

    def sign_out
      @browser.find_element(class: 'logout').click
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

      issue_value = [1, 2, 3]
      issue_name = ['Bug #1', 'Feature #1', 'Support ticket #1']

    def add_issue(issue_value, issue_name)
      issue_value.zip(issue_name).each do |value, name|
         sleep 3
        option = Selenium::WebDriver::Support::Select.new(@browser.find_element(id: 'issue_tracker_id'))
        option.select_by(:value, value)
        sleep 3
        @browser.find_element(id: 'issue_subject').send_keys name
        @browser.find_element(id: 'issue_description').send_keys 'test'
        assignee = Selenium::WebDriver::Support::Select.new(@browser.find_element(id: 'issue_assigned_to_id'))
        assignee.select_by(:text, 'John Doe')
        @browser.find_element(name: 'commit').click
      end
    end
  end

  module GoToPage
    def open_register_page
      @browser.find_element(class: 'register').click
    end

    def go_to_issues_page
      @browser.find_element(class: 'issues').click
    end

    def go_to_issue_adding_page
      @browser.find_element(class: 'new-issue').click
    end
  end

  module Validate
    def successfull_registration
      fail 'Test is failed' unless @browser.find_element(id: 'flash_notice').text == 'Your account has been activated. You can now log in.'
    end

    def checking_flash_for_pswd
      fail 'Test is failed' unless @browser.find_element(id: 'flash_notice').text == 'Password was successfully updated.'
    end

    def checking_flash_for_project
      fail 'Test is failed' unless @browser.find_element(id: 'flash_notice').text == 'Successful creation.'
    end
  end
end