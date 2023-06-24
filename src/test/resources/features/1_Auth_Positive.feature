Feature: OTP Feature Positive

  @Inventron @OTP @OTPNoAuthPositive @NoAuthRegister
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

  @Inventron @OTP @OTPNoAuthPositive @NoAuthLoginInventron
  Scenario: User login with idendity in API Inventron
    Given User user want call an api "/login" with method "POST" with payload below
      | email     | password     |
      | userEmail | userPassword |
    Then User verify status code is 200
    Then User user get auth token
    Then User verify response is match with json schema "authlogin.json"

  @Inventron @OTP @OTPNoAuthPositive @NoAuthGenerateOTP
  Scenario: User generate otp in API Inventron
    Given User user want call an api "/forgot-password/generate" with method "POST" with payload below
      | email     |
      | userEmail |
    Then User verify status code is 200
    Then User verify response is match with json schema "authGetOtp.json"

  @Inventron @OTP @OTPNoAuthPositive @NoAuthVerifyOTP
  Scenario: User verify otp in API Inventron
    Given User user want call an api "/forgot-password/verify" with method "POST" with payload below
      | email     | otp  |
      | userEmail | 9667 |
    Then User verify status code is 200
    Then User verify response is match with json schema "authVerifyOtp.json"

  @Inventron @OTP @OTPAuthPositive @AuthUpdatePassword
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
