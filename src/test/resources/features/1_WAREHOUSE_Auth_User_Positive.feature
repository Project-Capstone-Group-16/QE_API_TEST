Feature: Authentication User Positive

@Inventron @Auth @AuthRegister
Scenario: User register with idendity in API Inventron
  Given User is call an api "/register" with method "POST" with payload below
    | email           | password           | confirm_password |
    | randomUserEmail | randomUserPassword | userPassword    |
  Then User verify status code is 200
  Then User verify response is match with json schema "authregist.json"
  Given User is call an api "/login" with method "POST" with payload below
    | email     | password     |
    | userEmail | userPassword |
  Then User verify status code is 200
  Then User verify response is match with json schema "authlogin.json"

@Inventron @Auth @AuthLoginInventron
Scenario: User login with idendity in API Inventron
  Given User is call an api "/login" with method "POST" with payload below
  | email     | password     |
  | userEmail | userPassword |
  Then User verify status code is 200
  Then User user get auth token
  Then User verify response is match with json schema "authlogin.json"

@Inventron @Auth @AuthGenerateOTP
Scenario: User generate otp in API Inventron
  Given User is call an api "/forgot-password/generate" with method "POST" with payload below
    | email     |
    | userEmail |
  Then User verify status code is 200
  Then User verify response is match with json schema "authget&verifyotp.json"

@Inventron @Auth @AuthVerifyOTP
Scenario: User verify otp in API Inventron
  Given User is call an api "/forgot-password/verify" with method "POST" with payload below
    | otp  |
    | 9886 |
  Then User verify status code is 200
  Then User verify response is match with json schema "authget&verifyotp.json"

@Inventron @Auth @AuthUpdatePassword
Scenario: User update password in API Inventron
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
    | randomUserPassword | userPassword     |
  Then User verify status code is 200
  Then User verify response is match with json schema "authchangepass.json"
  Given User is call an api "/login" with method "POST" with payload below
    | email     | password     |
    | userEmail | userPassword |
  Then User verify status code is 200
  Then User user get auth token
  Then User verify response is match with json schema "authlogin.json"
