Feature: Basic functionality

  Scenario: Go to register page
    Given I am on home page
    When I click "register" link
    Then I get to register page

  Scenario Outline: User's registration
    Given I am on register page
    And I input <user_name> to Login field
    And I input <password> to Password field
    And I input <confirmation> to Confirmation field
    And I input <first_name> to First name field
    And I input <last_name> to Last name field
    And I input <email> to Email field
    When I click Submit button
    Then I am registered

    Examples:

    | user_name | password | confirmation | first_name | last_name | email            |
    | Jimmy3    | 112233   | 112233       | John       | Doe       | jimmy3@exmpl.com |
    | Jimmy4    | 112233   | 112233       | John       | Smith     | jimmy4@exmpl.com |

  Scenario: Sign In
    Given I am on Sign In page
    And I enter Jimmy3 to Login field
    And I enter 112233 to Password field
    When I click Login button
    Then I am logged in as Jimmy3


  Scenario: Sign Out
    Given I am signed in as Jimmy3, 112233
    When I click Sign Out link
    Then I get to home page


  Scenario: Change password
    Given I am signed in as Jimmy3, 112233
    When I go to Change password page
    And I enter 112233 to Password field
    And I enter 223344 to New password field
    And I enter 223344 to Confirmation field
    And click Apply button
    Then I see message that my password is changed
