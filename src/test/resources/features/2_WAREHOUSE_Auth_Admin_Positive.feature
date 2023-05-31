Feature: Authentication Admin Positive

  @Inventron @Auth @Admin @AdminAuth @AdminRegister
  Scenario: Admin register with idendity in API Inventron
    Given Admin is call an api "/register/admin" with method "POST" with payload below
      | full_name      | email       | phone_number | password       | confirm_password |
      | randomFullname | randomEmail | 85591717699 | randomPassword | adminPassword    |
    Then Admin verify status code is 200
    Then Admin verify response is match with json schema "adminRegis.json"
    Given Admin is call an api "/login/admin" with method "POST" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    Then Admin verify status code is 200
    Then Admin verify response is match with json schema "authlogin.json"

  @Inventron @Auth @Admin @AdminAuth @AdminLogin
  Scenario: Admin login with idendity in API Inventron
    Given Admin is call an api "/login/admin" with method "POST" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    And Admin verify status code is 200
    Then Admin admin get auth token
    Then Admin verify response is match with json schema "authlogin.json"

  @Inventron @Auth @Admin @AdminAuth @AdminCreateWarehouse
  Scenario: Admin create warehouse in API Inventron
    Given Admin is call an api "/login/admin" with method "POST" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    And Admin verify status code is 200
    And Admin verify response is match with json schema "authlogin.json"
    Then Admin admin get auth token
    Given Admin create warehouse "/admin/warehouse" method "POST"
    And Admin verify status code is 200
    And Admin verify response is match with json schema "createWarehouse.json"

  @Inventron @Auth @Admin @AdminAuth @AdminUpdateWarehouse
  Scenario: Admin update warehouse in API Inventron
    Given Admin is call an api "/login/admin" with method "POST" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    And Admin verify status code is 200
    And Admin verify response is match with json schema "authlogin.json"
    Then Admin admin get auth token
    Given Admin call api "/admin/warehouse/3" with method "PUT"
    And Admin verify status code is 200
    And Admin verify response is match with json schema "createWarehouse.json"

  @Inventron @Auth @Admin @AdminAuth @AdminGetAllWarehouse
  Scenario: Admin get all warehouse in API Inventron
    Given Admin is call an api "/login/admin" with method "POST" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    And Admin verify status code is 200
    And Admin verify response is match with json schema "authlogin.json"
    Then Admin admin get auth token
    Given Admin call api "/admin/warehouse" with method "GET"
    And Admin verify status code is 200
    And Admin verify response is match with json schema "getAllWarehouse.json"

  @Inventron @Auth @Admin @AdminAuth @AdminDeletWarehouseById
  Scenario: Admin delete warehouse by id in API Inventron
    Given Admin is call an api "/login/admin" with method "POST" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    And Admin verify status code is 200
    And Admin verify response is match with json schema "authlogin.json"
    Then Admin admin get auth token
    Given Admin call api "/admin/warehouse/5" with method "DELETE"
    Then Admin verify status code is 200

