Feature: User Feature Positive

  @Inventron @User @Auth @FavoriteWarehouse
  Scenario: User create favorite warehouse
    Given User user want call an api "/login" with method "POST" with payload below
      | email     | password     |
      | userEmail | userPassword |
    Then User verify status code is 200
    Then User user get auth token
    Then User verify response is match with json schema "authlogin.json"
    Given User want favorite warehouse path "/warehouse/favorite" with method "POST"
    Then User verify status code is 200

  @Inventron @User @Auth @GetProfile
  Scenario: User Get their profile account
    Given User user want call an api "/login" with method "POST" with payload below
      | email     | password     |
      | userEmail | userPassword |
    Then User verify status code is 200
    Then User user get auth token
    Then User verify response is match with json schema "authlogin.json"
    Given User user call an api "/profile" with method "GET"
    And User verify status code is 200
    Then User verify response is match with json schema "userGetProfile.json"

  @Inventron @User @Auth @UpdateProfile
  Scenario: User update profile
    Given User user want call an api "/login" with method "POST" with payload below
      | email     | password     |
      | userEmail | userPassword |
    Then User verify status code is 200
    Then User user get auth token
    Then User verify response is match with json schema "authlogin.json"
    Given User user want call an api "/profile/update" with method "PUT" with payload below
      | first_name      | last_name      | birth_date | gender | phone_number | address       | image_url |
      | randomFirstname | randomLastname | 25/04/2002 | gender | 85591717699  | randomAddress | imageUrl  |
    And User verify status code is 200
    Then User verify response is match with json schema "userUpdateProfile.json"

  @Inventron @User @Auth @CreateTransaction
  Scenario: User create transaction
    Given User user want call an api "/login" with method "POST" with payload below
      | email     | password     |
      | userEmail | userPassword |
    Then User verify status code is 200
    Then User user get auth token
    Then User verify response is match with json schema "authlogin.json"
    Given User want make transaction path "/warehouse/favorite" with method "POST"
    And User verify status code is 200
    Then User verify response is match with json schema "userUpdateProfile.json"

#    Get Favorite

#    Get Transaction