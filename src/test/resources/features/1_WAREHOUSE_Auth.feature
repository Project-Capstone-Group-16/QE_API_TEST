Feature: Authentication

  @Inventron @Auth @AuthRegister
  Scenario: User register with idendity in API Inventron
    Given User is call an api "/register" with method "POST" with payload below
      | email       | password       | confirmPassword |
      | randomEmail | randomPassword | confirmPassword |
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
    Then User verify response is match with json schema "authlogin.json"

  @Inventron @Auth @AuthGenerateOTP
  Scenario: User generate otp in API Inventron
    Given User verify some otp
    Then User verify status code is 200
    Then User verify response is match with json schema "authget&verifyotp.json"

  @Inventron @Auth @AuthVerifyOTP
  Scenario: User verify otp in API Inventron
    Given User verify some otp
    Then User verify status code is 200
    Then User verify response is match with json schema "authget&verifyotp.json"

  @Inventron @Auth @AuthUpdatePassword
  Scenario: User update password in API Inventron
    Given User update password account
    Then User verify status code is 200
    Then User verify response is match with json schema "authchangepass.json"

  @Inventron @Auth @Admin @AdminRegister
  Scenario: Admin register in API Inventron
    Given Admin call an api "/register/admin" with method "POST" with payload below
      | full_name      | email       | phone_number | password       | confirm_password |
      | randomFullname | randomEmail | 08132265499  | randomPassword | confirmPassword  |
    Then Admin verify status code is 200
    Then Admin verify response is match with json schema "adminregist.json"
    Given Admin call an api "/login/admin" with method "POST" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    Then Admin verify status code is 200
    Then Admin verify response is match with json schema "authlogin.json"

  @Inventron @Auth @Admin @AdminRegister
  Scenario: Admin register in API Inventron
    Given Admin call an api "/login/admin" with method "POST" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    Then Admin verify status code is 200
    Then Admin verify response is match with json schema "authlogin.json"

  @Inventron @Auth @Admin @CreateWarehouse
  Scenario: Admin create warehouse in API Inventron
    Given Admin call an api "/admin/warehouse" with method "POST" with payload below
      | name          | location          | warehouse_image |
      | nameInventron | locationInventron | linkImage       |
    And Admin get auth token
    Then Admin verify status code is 200
    Then Admin verify response is match with json schema "createwarehouse.json"

  @Inventron @Auth @Admin @UpdateWarehouse
  Scenario: Admin update warehouse in API Inventron
    Given Admin call an api "/admin/warehouse/3" with method "PUT" with payload below
      | name          | location          | status        | warehouse_image |
      | nameInventron | locationInventron | Not Available | linkImage       |
    And Admin get auth token
    Then Admin verify status code is 200
    Then Admin verify response is match with json schema "createwarehouse.json"

  @Inventron @Auth @Admin @GetAllWarehouse
  Scenario: Admin get all warehouse in API Inventron
    Given Admin call an api "/admin/warehouse" with method "GET"
    And Admin get auth token
    Then Admin verify status code is 200
    Then Admin verify response is match with json schema "getAllWarehouse.json"

  @Inventron @Auth @Admin @DeleteWarehouseById
  Scenario: Admin delete warehouse by id in API Inventron
    Given Admin call an api "/admin/warehouse/1" with method "DELETE"
    And Admin get auth token
    Then Admin verify status code is 200


