Feature: Authentication User Negative

  @Inventron @Auth @AuthRegister @RegisterWithValidEmailAndInvalidPassword
  Scenario: User register with idendity in API Inventron with valid email and invalid password
    Given User is call an api "/register" with method "POST" with payload below
      | email           | password           | confirm_password   |
      | randomUserEmail | randomUserPassword | randomUserPassword |
    Then User verify status code is 400

  @Inventron @Auth @AuthRegister @RegisterWithInvalidEmailAndValidPassword
  Scenario: User register with idendity in API Inventron with invalid email and valid password
    Given User is call an api "/register" with method "POST" with payload below
      | email       | password           | confirm_password   |
      | samtingwong | randomUserPassword | userPassword |
    Then User verify status code is 400

  @Inventron @Auth @AuthRegister @RegisterWithInvalidEmailAndInvalidPassword
  Scenario: User register with idendity in API Inventron with invalid email and invalid password
    Given User is call an api "/register" with method "POST" with payload below
      | email       | password           | confirm_password |
      | samtingwong | randomUserPassword | userPassword     |
    Then User verify status code is 400

  @Inventron @Auth @AuthLogin @LoginWithValidEmailAndInvalidPassword
  Scenario: User login with idendity in API Inventron with valid email and invalid password
    Given User is call an api "/login" with method "POST" with payload below
      | email     | password           |
      | userEmail | randomUserPassword |
    Then User verify status code is 400

  @Inventron @Auth @AuthLogin @LoginWithInvalidEmailAndValidPassword
  Scenario: User login with idendity in API Inventron with invalid email and valid password
    Given User is call an api "/login" with method "POST" with payload below
      | email       | password           |
      | samtingwong | userPassword |
    Then User verify status code is 400

  @Inventron @Auth @AuthLogin @LoginWithInvalidEmailAndInvalidPassword
  Scenario: User login with idendity in API Inventron with invalid email and invalid password
    Given User is call an api "/login" with method "POST" with payload below
      | email       | password           |
      | samtingwong | randomUserPassword |
    Then User verify status code is 400

  @Inventron @Auth @AuthGenerateOTP @WithRandomEmailNotRegisterToDatabase
  Scenario: User generate otp in API Inventron with random email not register to database
    Given User is call an api "/forgot-password/generate" with method "POST" with payload below
      | email     |
      | randomUserEmail |
    Then User verify status code is 400

  @Inventron @Auth @AuthGenerateOTP @WithWrongPayload
  Scenario: User generate otp in API Inventron with wrong payload
    Given User is call an api "/forgot-password/generate" with method "POST" with payload below
      | email       |
      | samtingwong |
    Then User verify status code is 400

  @Inventron @Auth @AuthVerifyOTP @WithWrongOtp
  Scenario: User verify otp in API Inventron with wrong otp
    Given User is call an api "/forgot-password/verify" with method "POST" with payload below
      | otp  |
      | 1234 |
    Then User verify status code is 400

  @Inventron @Auth @AuthVerifyOTP @WithOneCode
  Scenario: User verify otp in API Inventron with one code
    Given User is call an api "/forgot-password/verify" with method "POST" with payload below
      | otp  |
      | 1 |
    Then User verify status code is 400

  @Inventron @Auth @AuthVerifyOTP @WithText
  Scenario: User verify otp in API Inventron with text
    Given User is call an api "/forgot-password/verify" with method "POST" with payload below
      | otp  |
      | abcd |
    Then User verify status code is 400

  @Inventron @Auth @AuthUpdatePassword @UpdatePasswordWithLessThan6Character
  Scenario: User update password in API Inventron with less than 6 character
    Given User is call an api "/register" with method "POST" with payload below
      | email           | password           | confirm_password |
      | randomUserEmail | randomUserPassword | userPassword    |
    Then User verify status code is 200
    Then User verify response is match with json schema "authregist.json"
    Given User is call an api "/login" with method "POST" with payload below
      | email     | password     |
      | userEmail | userPassword |
    Then User verify status code is 200
    Then User user get auth token
    Then User verify response is match with json schema "authlogin.json"
    Given User is call an api "/forgot-password/update" with method "PUT" with payload below
      | password | confirm_password |
      | a        | a                |
    Then User verify status code is 400

  @Inventron @Auth @AuthUpdatePassword @UpdatePasswordWithincorrectPayloadPasswordAndConfirmPassword
  Scenario: User update password in API Inventron with incorrect payload password and confirm password
    Given User is call an api "/register" with method "POST" with payload below
      | email           | password           | confirm_password |
      | randomUserEmail | randomUserPassword | userPassword    |
    Then User verify status code is 200
    Then User verify response is match with json schema "authregist.json"
    Given User is call an api "/login" with method "POST" with payload below
      | email     | password     |
      | userEmail | userPassword |
    Then User verify status code is 200
    Then User user get auth token
    Then User verify response is match with json schema "authlogin.json"
    Given User is call an api "/forgot-password/update" with method "PUT" with payload below
      | password           | confirm_password   |
      | randomUserPassword | randomUserPassword |
    Then User verify status code is 400

  @Inventron @Auth @AuthUpdatePassword @UpdatePasswordWithWrongPayloadPasswordLessThan6AndNotMatch
  Scenario: User update password in API Inventron password less than 6
    Given User is call an api "/register" with method "POST" with payload below
      | email           | password           | confirm_password |
      | randomUserEmail | randomUserPassword | userPassword    |
    Then User verify status code is 200
    Then User verify response is match with json schema "authregist.json"
    Given User is call an api "/login" with method "POST" with payload below
      | email     | password     |
      | userEmail | userPassword |
    Then User verify status code is 200
    Then User user get auth token
    Then User verify response is match with json schema "authlogin.json"
    Given User is call an api "/forgot-password/update" with method "PUT" with payload below
      | password | confirm_password   |
      | a        | randomUserPassword |
    Then User verify status code is 400

  @Inventron @Auth @AuthUpdatePassword @UpdatePasswordWithWrongPayloadPasswordAndConfirmPasswordNotMatch
  Scenario: User update password in API Inventron confirm password not match
    Given User is call an api "/register" with method "POST" with payload below
      | email           | password           | confirm_password |
      | randomUserEmail | randomUserPassword | userPassword    |
    Then User verify status code is 200
    Then User verify response is match with json schema "authregist.json"
    Given User is call an api "/login" with method "POST" with payload below
      | email     | password     |
      | userEmail | userPassword |
    Then User verify status code is 200
    Then User user get auth token
    Then User verify response is match with json schema "authlogin.json"
    Given User is call an api "/forgot-password/update" with method "PUT" with payload below
      | password           | confirm_password |
      | randomUserPassword | a                |
    Then User verify status code is 400