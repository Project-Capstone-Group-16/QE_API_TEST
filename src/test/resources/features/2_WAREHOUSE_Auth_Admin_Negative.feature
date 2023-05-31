Feature: Authentication Admin Negative

  @Inventron @Auth @Admin @AdminRegister @Negative @NumberLessThen5
  Scenario: Admin register with number less then 5 in API Inventron
    Given Admin is call an api "/register/admin" with method "POST" with payload below
    | full_name      | email       | phone_number | password       | confirm_password |
    | randomFullname | randomEmail | 8559         | randomPassword | adminPassword    |
    Then Admin verify status code is 400

  @Inventron @Auth @Admin @AdminRegister @Negative @NumberMoreThen12
  Scenario: Admin register with number more then 12 in API Inventron
    Given Admin is call an api "/register/admin" with method "POST" with payload below
    | full_name      | email       | phone_number    | password       | confirm_password |
    | randomFullname | randomEmail | 855917176999123 | randomPassword | adminPassword    |
    Then Admin verify status code is 400

  @Inventron @Auth @Admin @AdminRegister @Negative @NotUsingEmail
  Scenario: Admin register with email not using email in API Inventron
    Given Admin is call an api "/register/admin" with method "POST" with payload below
    | full_name      | email          | phone_number | password       | confirm_password |
    | randomFullname | randomFullname | 855917176999 | randomPassword | adminPassword    |
    Then Admin verify status code is 400

  @Inventron @Auth @Admin @AdminRegister @Negative @UsingAlreadyRegistered
  Scenario: Admin register with email already registered in API Inventron
    Given Admin is call an api "/register/admin" with method "POST" with payload below
    | full_name      | email      | phone_number | password      | confirm_password |
    | randomFullname | adminEmail | 855917176999 | adminPassword | adminPassword    |
    Then Admin verify status code is 400

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

  @Inventron @Auth @Admin @AdminDeletWarehouseById
  Scenario: Admin delete warehouse by id after delete warehouse in API Inventron
    Given Admin is call an api "/login/admin" with method "POST" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    And Admin verify status code is 200
    And Admin verify response is match with json schema "authlogin.json"
    Then Admin admin get auth token
    Given Admin call api "/admin/warehouse/100" with method "DELETE"
    Then Admin verify status code is 400