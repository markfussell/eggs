Feature: Create Locations
  As a manager
  In order to schedule deliveries
  I need to be able to create locations for a particular farm

Background:
  Given there is a farm "Soul Food Farm"
  Given I am logged in as an admin

Scenario: View location Index
  Given the farm has a location "Soul Food Farm" with host "Alexis" and tag "Farm"
  Given I am at Soul Food Farm
  Then I should see "Manage Locations"
  When I follow "Manage Locations"
  Then I should see "Pickup Locations"
  And I should see "Alexis"
  And I should not see "Julia Childs"
  
Scenario: Create a new location
  Given the farm has a location "SF / Potrero" with host "Alexis" and tag "SF-Potrero"  
  Given I am at Soul Food Farm
  When I follow "Manage Locations"
  And I follow "Create New location"
  And I fill in the form with a location
  And I select "SF-Potrero" from "location_location_tag_id"
  And I press "Create"
  Then I should see "Pickup Locations"
