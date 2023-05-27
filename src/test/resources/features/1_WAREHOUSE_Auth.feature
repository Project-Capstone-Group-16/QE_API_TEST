Feature: Authentication

  @Inventron @Auth @AuthRegister
  Scenario: User register with idendity in API Inventron
    Given User is call an api "/register" with method "POST" with payload below
      | email       | password       | confirmPassword |
      | randomEmail | passwordRegist | passwordRegist  |
    Then User verify status code is 200
    Then User verify response is match with json schema "authregist.json"

  @Inventron @Auth @AuthLoginInventron
  Scenario: User login with idendity in API Inventron
    Given User is call an api "/login" with method "POST" with payload below
      | email     | password     |
      | userEmail | userPassword |
    Then User verify status code is 200
    Then User verify response is match with json schema "authlogin.json"

#  @Inventron @Auth @AuthGenerateOTP
#  Scenario: User generate otp in API Inventron
#    Given User verify some otp
#    Then User verify status code is 200
#    Then User verify response is match with json schema "authget&verifyotp.json"
#
#  @Inventron @Auth @AuthVerifyOTP
#  Scenario: User verify otp in API Inventron
#    Given User verify some otp
#    Then User verify status code is 200
#    Then User verify response is match with json schema "authget&verifyotp.json"
#
#  @Inventron @Auth @AuthUpdatePassword
#  Scenario: User update password in API Inventron
#    Given User update password account
#    Then User verify status code is 200
#    Then User verify response is match with json schema "authchangepass.json"

  @Inventron @Auth @Admin @AdminRegister
  Scenario: Admin register with idendity in API Inventron
    Given Admin is call an api "/register/admin" with method "POST" with payload below
      | full_name      | email       | phone_number | password       | confirm_password |
      | randomFullname | randomEmail | 855917176999 | randomPassword | adminPassword    |
    Then Admin verify status code is 200
    Then Admin verify response is match with json schema "adminRegis.json"
    Given Admin is call an api "/login/admin" with method "POST" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    Then Admin verify status code is 200
    Then Admin verify response is match with json schema "authlogin.json"

  @Inventron @Auth @Admin @AdminLogin
  Scenario: Admin login with idendity in API Inventron
    Given Admin is call an api "/login/admin" with method "POST" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    And Admin verify status code is 200
    Then Admin verify response is match with json schema "authlogin.json"

#  @Inventron @Auth @Admin @AdminCreateWarehouse
#  Scenario: Admin create warehouse in API Inventron
#    Given Admin is call an api "/login/admin" with method "POST" with payload below
#      | email      | password      |
#      | adminEmail | adminPassword |
#    And Admin verify status code is 200
#    And Admin verify response is match with json schema "authlogin.json"
#    Then Admin get auth token
#    Given Admin create warehouse
#    And Admin verify status code is 200
#    And Admin verify response is match with json schema "createWarehouse.json"

  @Inventron @Auth @Admin @AdminGetAllWarehouse
  Scenario: Admin get all warehouse in API Inventron
    Given Admin is call an api "/login/admin" with method "POST" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    And Admin verify status code is 200
    And Admin verify response is match with json schema "authlogin.json"
    Then Admin get auth token
    Given Admin call api "/admin/warehouse" with method "GET"
    And Admin verify status code is 200
    And Admin verify response is match with json schema "getAllWarehouse.json"

  @Inventron @Auth @Admin @AdminDeletWarehouseById
  Scenario: Admin delete warehouse by id in API Inventron
    Given Admin is call an api "/login/admin" with method "POST" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    And Admin verify status code is 200
    And Admin verify response is match with json schema "authlogin.json"
    Then Admin get auth token
    Given Admin call api "/admin/warehouse/1" with method "DELETE"
    Then Admin verify status code is 200

  @Inventron @Auth @Admin @AdminRegister @Negative @NumberLessThen5
  Scenario: Admin register with number less then 5 in API Inventron
    Given Admin is call an api "/register/admin" with method "POST" with payload below
      | full_name      | email       | phone_number | password       | confirm_password |
      | randomFullname | randomEmail | 8559         | randomPassword | adminPassword    |
    Then Admin verify status code is 400
#    Then Admin verify response is match with json schema "adminRegisFailure.json"

  @Inventron @Auth @Admin @AdminRegister @Negative @NumberMoreThen12
  Scenario: Admin register with number more then 12 in API Inventron
    Given Admin is call an api "/register/admin" with method "POST" with payload below
      | full_name      | email       | phone_number    | password       | confirm_password |
      | randomFullname | randomEmail | 855917176999123 | randomPassword | adminPassword    |
    Then Admin verify status code is 400
#    Then Admin verify response is match with json schema "adminRegisFailure.json"

  @Inventron @Auth @Admin @AdminRegister @Negative @NotUsingEmail
  Scenario: Admin register with email not using email in API Inventron
    Given Admin is call an api "/register/admin" with method "POST" with payload below
      | full_name      | email          | phone_number | password       | confirm_password |
      | randomFullname | randomFullname | 855917176999 | randomPassword | adminPassword    |
    Then Admin verify status code is 400
#    Then Admin verify response is match with json schema "adminRegisFailure.json"

  @Inventron @Auth @Admin @AdminRegister @Negative @UsingAlreadyRegistered
  Scenario: Admin register with email already registered in API Inventron
    Given Admin is call an api "/register/admin" with method "POST" with payload below
      | full_name      | email      | phone_number | password      | confirm_password |
      | randomFullname | adminEmail | 855917176999 | adminPassword | adminPassword    |
    Then Admin verify status code is 400
#    Then Admin verify response is match with json schema "adminRegisFailure.json"

  @Inventron @Auth @Admin @AdminLogin @Negative @InvalidEmailAndPassword
  Scenario: Admin login using invalid email and password in API Inventron
    Given Admin is call an api "/login/admin" with method "POST" with payload below
      | email       | password       |
      | randomEmail | randomPassword |
    Then Admin verify status code is 400

  @Inventron @Auth @Admin @AdminLogin @Negative @ValidEmailAndInvalidPassword
  Scenario: Admin login using valid email and invalid password in API Inventron
    Given Admin is call an api "/login/admin" with method "POST" with payload below
      | email      | password       |
      | adminEmail | randomPassword |
    Then Admin verify status code is 400

  @Inventron @Auth @Admin @AdminLogin @Negative @InvalidEmailAndValidPassword
  Scenario: Admin login using invalid email and valid password in API Inventron
    Given Admin is call an api "/login/admin" with method "POST" with payload below
      | email       | password      |
      | randomEmail | adminPassword |
    Then Admin verify status code is 400

  @Inventron @Auth @Admin @AdminLogin @Negative @UsingSqlInjection
  Scenario: Admin login using sql injection in API Inventron
    Given Admin is call an api "/login/admin" with method "POST" with payload below
      | email       | password    |
      | ' OR '' = ' | " OR "" = " |
    Then Admin verify status code is 400