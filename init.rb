require 'selenium-webdriver'

require_relative 'user'
require_relative 'project'
require_relative 'helpers'


include Helpers::GoToPage
include Helpers::Validate
include Helpers::UserActions
include Helpers::ProjectActions

declare
open_register_page
user1 = User.new('John1', '112233')
register_as(user1)