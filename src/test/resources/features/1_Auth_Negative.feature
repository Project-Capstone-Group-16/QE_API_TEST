Feature: Authentication User Negative

  @Inventron @Auth @AuthRegister @RegisterWithValidEmailAndInvalidPassword
  Scenario: User register with idendity in API Inventron with valid email and invalid password
    Given User user want call an api "/register" with method "POST" with payload below
      | email           | password           | confirm_password   |
      | randomUserEmail | randomUserPassword | randomUserPassword |
    Then User verify status code is 400

  @Inventron @Auth @AuthRegister @RegisterWithInvalidEmailAndValidPassword
  Scenario: User register with idendity in API Inventron with invalid email and valid password
    Given User user want call an api "/register" with method "POST" with payload below
      | email       | password           | confirm_password   |
      | samtingwong | randomUserPassword | userPassword |
    Then User verify status code is 400

  @Inventron @Auth @AuthRegister @RegisterWithInvalidEmailAndInvalidPassword
  Scenario: User register with idendity in API Inventron with invalid email and invalid password
    Given User user want call an api "/register" with method "POST" with payload below
      | email       | password           | confirm_password |
      | samtingwong | randomUserPassword | userPassword     |
    Then User verify status code is 400

  @Inventron @Auth @AuthLogin @LoginWithValidEmailAndInvalidPassword
  Scenario: User login with idendity in API Inventron with valid email and invalid password
    Given User user want call an api "/login" with method "POST" with payload below
      | email     | password           |
      | userEmail | randomUserPassword |
    Then User verify status code is 400

  @Inventron @Auth @AuthLogin @LoginWithInvalidEmailAndValidPassword
  Scenario: User login with idendity in API Inventron with invalid email and valid password
    Given User user want call an api "/login" with method "POST" with payload below
      | email       | password           |
      | samtingwong | userPassword |
    Then User verify status code is 400

  @Inventron @Auth @AuthLogin @LoginWithInvalidEmailAndInvalidPassword
  Scenario: User login with idendity in API Inventron with invalid email and invalid password
    Given User user want call an api "/login" with method "POST" with payload below
      | email       | password           |
      | samtingwong | randomUserPassword |
    Then User verify status code is 400

  @Inventron @Auth @AuthGenerateOTP @WithRandomEmailNotRegisterToDatabase
  Scenario: User generate otp in API Inventron with random email not register to database
    Given User user want call an api "/forgot-password/generate" with method "POST" with payload below
      | email           |
      | randomUserEmail |
    Then User verify status code is 400

  @Inventron @Auth @AuthGenerateOTP @GenerateOtpWithWrongPayload
  Scenario: User generate otp in API Inventron with wrong payload
    Given User user want call an api "/forgot-password/generate" with method "POST" with payload below
      | email       |
      | samtingwong |
    Then User verify status code is 400

  @Inventron @Auth @AuthVerifyOTP @VerifyOtpWithWrongOtp
  Scenario: User verify otp in API Inventron with wrong otp
    Given User user want call an api "/forgot-password/verify" with method "POST" with payload below
      | email     | otp  |
      | userEmail | 1234 |
    Then User verify status code is 400

  @Inventron @Auth @AuthVerifyOTP @VerifyOtpWithOneCode
  Scenario: User verify otp in API Inventron with less 4 code
    Given User user want call an api "/forgot-password/verify" with method "POST" with payload below
      | email     | otp  |
      | userEmail | 1    |
    Then User verify status code is 400

  @Inventron @Auth @AuthVerifyOTP @VerifyOtpWithWrongEmailWrongOtp
  Scenario: User verify otp in API Inventron with wrong otp & not register email
    Given User user want call an api "/forgot-password/verify" with method "POST" with payload below
      | email           | otp  |
      | randomUserEmail | 1234 |
    Then User verify status code is 400

  @Inventron @Auth @AuthVerifyOTP @VerifyOtpWithWrongEmailWithOneCode
  Scenario: User verify otp in API Inventron with less 4 code & not register email
    Given User user want call an api "/forgot-password/verify" with method "POST" with payload below
      | email           | otp  |
      | randomUserEmail | 1    |
    Then User verify status code is 400

  @Inventron @Auth @AuthVerifyOTP @VerifyOtpWithWrongEmailPayloadWithWrongOtp
  Scenario: User verify otp in API Inventron with wrong otp & wrong payload email
    Given User user want call an api "/forgot-password/verify" with method "POST" with payload below
      | email       | otp  |
      | samtingwong | 1234 |
    Then User verify status code is 400

  @Inventron @Auth @AuthVerifyOTP @VerifyOtpWithWrongEmailPayloadWithOneCode
  Scenario: User verify otp in API Inventron with less 4 code & wrong payload email
    Given User user want call an api "/forgot-password/verify" with method "POST" with payload below
      | email       | otp  |
      | samtingwong | 1    |
    Then User verify status code is 400

  @Inventron @Auth @AuthVerifyOTP @VerifyOtpWithText
  Scenario: User verify otp in API Inventron with text
    Given User user want call an api "/forgot-password/verify" with method "POST" with payload below
      | email     | otp  |
      | userEmail | abcd |
    Then User verify status code is 400

  @Inventron @Auth @AuthVerifyOTP @VerifyOtpWithTextWithOneCode
  Scenario: User verify otp in API Inventron with text less 4 code
    Given User user want call an api "/forgot-password/verify" with method "POST" with payload below
      | email     | otp  |
      | userEmail | a    |
    Then User verify status code is 400

  @Inventron @Auth @AuthVerifyOTP @VerifyOtpWithWrongEmailAndText
  Scenario: User verify otp in API Inventron with text & not register email
    Given User user want call an api "/forgot-password/verify" with method "POST" with payload below
      | email           | otp  |
      | randomUserEmail | abcd |
    Then User verify status code is 400

  @Inventron @Auth @AuthVerifyOTP @VerifyOtpWithWrongEmailAndWithTextOneCode
  Scenario: User verify otp in API Inventron with text less 4 code & not register email
    Given User user want call an api "/forgot-password/verify" with method "POST" with payload below
      | email           | otp  |
      | randomUserEmail | a    |
    Then User verify status code is 400

  @Inventron @Auth @AuthVerifyOTP @VerifyOtpWithWrongEmailPayloadAndWithText
  Scenario: User verify otp in API Inventron with wrong otp & wrong payload email
    Given User user want call an api "/forgot-password/verify" with method "POST" with payload below
      | email       | otp  |
      | samtingwong | abcd |
    Then User verify status code is 400

  @Inventron @Auth @AuthVerifyOTP @VerifyOtpWithWrongEmailPayloadAndWithTextOneCode
  Scenario: User verify otp in API Inventron with less 4 code & wrong payload email
    Given User user want call an api "/forgot-password/verify" with method "POST" with payload below
      | email       | otp  |
      | samtingwong | a    |
    Then User verify status code is 400

  @Inventron @Auth @AuthUpdatePassword @UpdatePasswordWithLessThan6Character
  Scenario: User update password in API Inventron with less than 6 character
    Given User user want call an api "/register" with method "POST" with payload below
      | email           | password           | confirm_password |
      | randomUserEmail | randomUserPassword | userPassword    |
    Then User verify status code is 200
    Then User verify response is match with json schema "authregist.json"
    Given User user want call an api "/login" with method "POST" with payload below
      | email     | password     |
      | userEmail | userPassword |
    Then User verify status code is 200
    Then User user get auth token
    Then User verify response is match with json schema "authlogin.json"
    Given User user want call an api "/forgot-password/update" with method "PUT" with payload below
      | password | confirm_password |
      | a        | a                |
    Then User verify status code is 400

  @Inventron @Auth @AuthUpdatePassword @UpdatePasswordWithincorrectPayloadPasswordAndConfirmPassword
  Scenario: User update password in API Inventron with incorrect payload password and confirm password
    Given User user want call an api "/register" with method "POST" with payload below
      | email           | password           | confirm_password |
      | randomUserEmail | randomUserPassword | userPassword    |
    Then User verify status code is 200
    Then User verify response is match with json schema "authregist.json"
    Given User user want call an api "/login" with method "POST" with payload below
      | email     | password     |
      | userEmail | userPassword |
    Then User verify status code is 200
    Then User user get auth token
    Then User verify response is match with json schema "authlogin.json"
    Given User user want call an api "/forgot-password/update" with method "PUT" with payload below
      | password           | confirm_password   |
      | randomUserPassword | randomUserPassword |
    Then User verify status code is 400

  @Inventron @Auth @AuthUpdatePassword @UpdatePasswordWithWrongPayloadPasswordLessThan6AndNotMatch
  Scenario: User update password in API Inventron password less than 6
    Given User user want call an api "/register" with method "POST" with payload below
      | email           | password           | confirm_password |
      | randomUserEmail | randomUserPassword | userPassword    |
    Then User verify status code is 200
    Then User verify response is match with json schema "authregist.json"
    Given User user want call an api "/login" with method "POST" with payload below
      | email     | password     |
      | userEmail | userPassword |
    Then User verify status code is 200
    Then User user get auth token
    Then User verify response is match with json schema "authlogin.json"
    Given User user want call an api "/forgot-password/update" with method "PUT" with payload below
      | password | confirm_password   |
      | a        | randomUserPassword |
    Then User verify status code is 400

  @Inventron @Auth @AuthUpdatePassword @UpdatePasswordWithWrongPayloadPasswordAndConfirmPasswordNotMatch
  Scenario: User update password in API Inventron confirm password not match
    Given User user want call an api "/register" with method "POST" with payload below
      | email           | password           | confirm_password |
      | randomUserEmail | randomUserPassword | userPassword    |
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
      | randomUserPassword | a                |
    Then User verify status code is 400