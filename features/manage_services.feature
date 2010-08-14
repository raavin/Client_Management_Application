Feature: Manage services
  In order to define Services
  As an admin
  I want to create and manage services
  
  Scenario: Create new service
    Given I am logged in as "jason@skys.org.au" with password "testor"
    When I go to the new service page
    When I fill in "Description" with "description 1"
    And I fill in "Min age" with "min_age 1"
    And I fill in "Max age" with "max_age 1"
    And I press "Create"
    Then I should see "service_name 1"
    And I should see "description 1"
    And I should see "min_age 1"
    And I should see "max_age 1"

  Scenario: Delete service
    Given the following services:
      |service_name|description|min_age|max_age|
      |service_name 1|description 1| 1| 1|
      |service_name 2|description 2| 2| 2|
      |service_name 3|description 3| 3| 3|
      |service_name 4|description 4| 4| 4|
    When I delete the 3rd service
    Then I should see the following services:
      |Service name|Description|Min age|Max age|
      |service_name 1|description 1| 1| 1|
      |service_name 2|description 2| 2| 2|
      |service_name 4|description 4| 4| 4|
