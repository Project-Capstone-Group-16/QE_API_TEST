Feature: Authentication User Positive

  @Inventron @Auth @AuthPositive @AuthRegister
  Scenario: User register with idendity in API Inventron
    Given User user want call an api "/register" with method "POST" with payload below
      | email           | password           | confirm_password |
      | randomUserEmail | randomUserPassword | userPassword     |
    Then User verify status code is 200
    Then User verify response is match with json schema "authregist.json"
    Given User user want call an api "/login" with method "POST" with payload below
      | email     | password     |
      | userEmail | userPassword |
    Then User verify status code is 200
    Then User verify response is match with json schema "authlogin.json"

  @Inventron @Auth @AuthPositive @AuthLoginInventron
  Scenario: User login with idendity in API Inventron
    Given User user want call an api "/login" with method "POST" with payload below
      | email     | password     |
      | userEmail | userPassword |
    Then User verify status code is 200
    Then User user get auth token
    Then User verify response is match with json schema "authlogin.json"

  @Inventron @Auth @AuthPositive @AuthGenerateOTP
  Scenario: User generate otp in API Inventron
    Given User user want call an api "/forgot-password/generate" with method "POST" with payload below
      | email     |
      | userEmail |
    Then User verify status code is 200
    Then User verify response is match with json schema "authGetOtp.json"

  @Inventron @Auth @AuthPositive @AuthVerifyOTP
  Scenario: User verify otp in API Inventron
    Given User user want call an api "/forgot-password/verify" with method "POST" with payload below
      | email     | otp  |
      | userEmail | 9667 |
    Then User verify status code is 200
    Then User verify response is match with json schema "authVerifyOtp.json"

  @Inventron @Auth @AuthPositive @AuthUpdatePassword
  Scenario: User update password in API Inventron
    Given User user want call an api "/register" with method "POST" with payload below
      | email           | password           | confirm_password |
      | randomUserEmail | randomUserPassword | userPassword     |
    Then User verify status code is 200
    Then User verify response is match with json schema "authregist.json"
    Given User user want call an api "/login" with method "POST" with payload below
      | email     | password     |
      | userEmail | userPassword |
    Then User verify status code is 200
    Then User user get auth token
    Then User verify response is match with json schema "authlogin.json"
    Given User user want call an api "/forgot-password/update" with method "PUT" with payload below
      | password           | confirm_password |
      | randomUserPassword | userPassword     |
    Then User verify status code is 200
    Then User verify response is match with json schema "authchangepass.json"
    Given User user want call an api "/login" with method "POST" with payload below
      | email     | password     |
      | userEmail | userPassword |
    Then User verify status code is 200
    Then User user get auth token
    Then User verify response is match with json schema "authlogin.json"

  @Inventron @User @RecommendedWarehouse
  Scenario: User create favorite warehouse
    Given User user want call an api "/login" with method "POST" with payload below
      | email     | password     |
      | userEmail | userPassword |
    And User verify status code is 200
    And User user get auth token
    Then User verify response is match with json schema "authlogin.json"
    Then User user call an api "/warehouse/recomended" with method "GET"
    And User verify status code is 200
    Then User verify response is match with json schema "getAllWarehouse.json"


  @Inventron @User @FavoriteWarehouse
  Scenario: User create favorite warehouse
    Given User user want call an api "/login" with method "POST" with payload below
      | email     | password     |
      | userEmail | userPassword |
    Then User verify status code is 200
    Then User user get auth token
    Then User verify response is match with json schema "authlogin.json"
    Given User want favorite warehouse path "/warehouse/favorite" with method "POST"
    Then User verify status code is 200

  @Inventron @User @UpdateProfile
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

  @Inventron @User @CreateTransaction
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