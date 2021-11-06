Feature: Calculator
  Scenario: Sum two numbers
    Given I have two numbers: 1 and 2
    When the calculator sums them
    Then I receive 3 as a result
    
  Scenario: Division two numbers
    Given I have two numbers for division: 21 and 3
    When the calculator divides them
    Then I receive 7 as a division result