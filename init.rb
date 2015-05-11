require 'selenium-webdriver'
require 'rspec'

require_relative 'user'
require_relative 'project'
require_relative 'helpers'


include Helpers::GoToPage
include Helpers::Validate
include Helpers::UserActions
include Helpers::ProjectActions

declare
open_register_page
user1 = User.new('Frodo12', '112233')

register_as(user1)
successful_registration
sign_out

open_register_page
user2 = User.new('Sam7', '112233')
register_as(user2)
successful_registration
sign_out


sing_in_as(user1)
change_password(user1)

create_project('SuperP7', 'duper')
create_project_version('v.1')
add_member(user2)

edit_user_role(user1)
edit_user_role(user2)

issues = {'1' => 'Bug #1', '2' => 'Feature #1', '3' => 'Support ticket #1'}
add_issue(issues, user1)
go_to_issues_page
displaying_ticket(issues)

