Feature: Authentication

  @Inventron @Auth @AuthRegister
  Scenario: User register with idendity
    Given User is call an api "/register" with method "POST" with payload below
      | email       | password       | confirmPassword |
      | randomEmail | passwordRegist | passwordRegist  |
    Then User verify status code is 200
    Then User verify response is match with json schema "authregist.json"

  @Inventron @Auth @AuthLogin
  Scenario: User login with idendity
    Given User is call an api "/login" with method "POST" with payload below
      | email     | password     |
      | userEmail | userPassword |
    Then User verify status code is 200
    Then User verify response is match with json schema "authlogin.json"

  @Inventron @Auth @AuthGenerateOTP
  Scenario: User generate otp
    Given User verify some otp
    Then User verify status code is 200
    Then User verify response is match with json schema "authget&verifyotp.json"

  @Inventron @Auth @AuthVerifyOTP
  Scenario: User verify otp
    Given User verify some otp
    Then User verify status code is 200
    Then User verify response is match with json schema "authget&verifyotp.json"

  @Inventron @Auth @AuthUpdatePassword
  Scenario: User update password
    Given User update password account
    Then User verify status code is 200
    Then User verify response is match with json schema "authchangepass.json"
