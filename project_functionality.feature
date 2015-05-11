
Feature: Project functionality

  Background:
    Given I am signed in as Jimmy3, 223344


  Scenario: Create project
    And I go to 'New project' page
    And I input project name ABRACADA
    And I input project identifier 4
    When I click 'Create' button
    Then I see system message about successful creation

  Scenario: Create project version
    And I go to settings of ABRACADA
    And I go to 'Versions' tab
    And I go to 'New version' page
    And I input new version name 3
    When I click 'Create' button
    Then I see system message about successful creation

  Scenario: Add member
    And I go to settings of ABRACADA
    And I go to 'Members' tab
    And I go to 'New member' modal
    And I search for John Smith
    And I click checkbox in front of found user
    And I define user's role
    When I click 'Add' button
    Then John Smith appears in project's member list


  Scenario: Edit user role
    And I am on 'Members' tab on 'Settings' page
    When I edit John Smith's role adding Developer and save it
    Then I see John Smith with Developer role in users' list


  Scenario Outline: Adding ticket
    And I am on project <project_name> page
    And I click 'New issue' tab
    And tracker is <tracker_value>
    And subject is <ticket_name>
    And description is 'test'
    And assignee is <user_fullname>
    When I click 'Create' button
    Then I see system message about successful creation
  Examples:
    | project_name   | tracker_value   | ticket_name         | user_fullname   |
    | ABRACADA       | Bug             | Test bug ticket     | John Smith      |
    | ABRACADA       | Feature         | Test feature ticket | John Smith      |
    | ABRACADA       | Support         | Test support ticket | John Smith      |


  Scenario Outline: Checking of tickets' displaying on 'Issue' page
    When I am on 'Issue' page
    Then I see <ticket_name> in the list of tickets
  Examples:
    | ticket_name         |
    | Test bug ticket     |
    | Test feature ticket |
    | Test support ticket |