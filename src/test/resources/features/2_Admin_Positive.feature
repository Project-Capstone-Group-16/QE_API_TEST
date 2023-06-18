Feature: Admin Feature Positive

  @Inventron @Admin @AdminNoAuth @AdminRegister
  Scenario: Admin register with idendity in API Inventron
    Given Admin admin want call an api "/register/admin" with method "POST" with payload below
      | first_name      | last_name      | email       | phone_number | password       | confirm_password |
      | randomFirstname | randomLastname | randomEmail | 85591717699  | randomPassword | adminPassword    |
    Then Admin verify status code is 200
    Then Admin verify response is match with json schema "adminRegis.json"
    Given Admin admin want call an api "/login/admin" with method "POST" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    Then Admin verify status code is 200
    Then Admin verify response is match with json schema "authlogin.json"

  @Inventron @Admin @AdminNoAuth @AdminLogin
  Scenario: Admin login with idendity in API Inventron
    Given Admin admin want call an api "/login/admin" with method "POST" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    And Admin verify status code is 200
    Then Admin admin get auth token
    Then Admin verify response is match with json schema "authlogin.json"

  @Inventron @Admin @AdminAuth @AdminCreateWarehouse
  Scenario: Admin create warehouse in API Inventron
    Given Admin admin want call an api "/login/admin" with method "POST" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    And Admin verify status code is 200
    And Admin verify response is match with json schema "authlogin.json"
    Then Admin admin get auth token
    Given Admin admin want call an api "/admin/warehouse" with method "POST" with payload below
      | name          | city          | address       | description          | image_url |
      | nameWarehouse | cityWarehouse | randomAddress | descriptionWarehouse | imageUrl  |
    And Admin verify status code is 200
    And Admin verify response is match with json schema "createWarehouse.json"

  @Inventron @Admin @AdminAuth @AdminUpdateWarehouse
  Scenario: Admin update warehouse in API Inventron
    Given Admin admin want call an api "/login/admin" with method "POST" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    And Admin verify status code is 200
    And Admin verify response is match with json schema "authlogin.json"
    Then Admin admin get auth token
#    And Admin automate get id "warehouse"
    Given Admin admin want call an api "/admin/warehouse/11" with method "PUT" with payload below
      | name          | city          | address       | description          | status    | image_url |
      | nameWarehouse | cityWarehouse | randomAddress | descriptionWarehouse | Available | imageUrl  |
    And Admin verify status code is 200
    And Admin verify response is match with json schema "updateWarehouse.json"

  @Inventron @Admin @AdminAuth @AdminGetAllWarehouse
  Scenario: Admin get all warehouse in API Inventron
    Given Admin admin want call an api "/login/admin" with method "POST" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    And Admin verify status code is 200
    And Admin verify response is match with json schema "authlogin.json"
    Then Admin admin get auth token
    Given Admin admin call api "/admin/warehouse" with method "GET"
    And Admin verify status code is 200
    And Admin verify response is match with json schema "getAllWarehouse.json"

  @Inventron @Auth @Admin @AdminAuth @AdminDeleteWarehouseById
  Scenario: Admin delete warehouse by id in API Inventron
    Given Admin admin want call an api "/login/admin" with method "POST" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    And Admin verify status code is 200
    And Admin verify response is match with json schema "authlogin.json"
    Then Admin admin get auth token
    Given Admin admin call api "/admin/warehouse/10" with method "DELETE"
    Then Admin verify status code is 200

  @Inventron @Auth @Admin @AdminAuth @CreateStaff
  Scenario: Admin create staff with idendity in API Inventron
    Given Admin admin want call an api "/login/admin" with method "POST" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    And Admin verify status code is 200
    Then Admin verify response is match with json schema "authlogin.json"
    Then Admin admin get auth token
    Given Admin admin want call an api "/admin/staff" with method "POST" with payload below
      | full_name      | occupation | birth_date | gender | phone_number | address       | image_url |
      | randomFullname | posision   | 25/04/2002 | gender | 85171212504  | randomAddress | imageUrl  |
    And Admin verify status code is 200
    Then Admin verify response is match with json schema "adminCreate&UpdateStaff.json"

  @Inventron @Auth @Admin @AdminAuth @UpdateStaffById
  Scenario: Admin update staff with idendity in API Inventron
    Given Admin admin want call an api "/login/admin" with method "POST" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    And Admin verify status code is 200
    Then Admin verify response is match with json schema "authlogin.json"
    Then Admin admin get auth token
    Given Admin admin want call an api "/admin/staff/1" with method "PUT" with payload below
      | full_name      | occupation | birth_date | gender | phone_number | address       | image_url |
      | randomFullname | posision   | 25/04/2002 | gender | 85171212504  | randomAddress | imageUrl  |
    And Admin verify status code is 200
    Then Admin verify response is match with json schema "adminCreate&UpdateStaff.json"


  @Inventron @Auth @Admin @AdminAuth @AdminDeleteStaffByID
  Scenario: Admin delete warehouse by id in API Inventron
    Given Admin admin want call an api "/login/admin" with method "DELETE" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    And Admin verify status code is 200
    And Admin verify response is match with json schema "AdminDeleteStaff.json"
    Then Admin admin get auth token
    Given Admin admin call api "/admin/staff/1" with method "DELETE"
    Then Admin verify status code is 200


  @Inventron @Auth @Admin @AdminAuth @GetALlStaff
  Scenario: Admin Get All User in Inventron
    Given Admin admin want call an api "/login/admin" with method "GET" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    And Admin verify status code is 200
    Then Admin verify response is match with json schema "authlogin.json"
    Then Admin admin get auth token
    Given Admin admin call api "/admin/staff" with method "GET"
    And Admin verify status code is 200
    Then Admin verify response is match with json schema "getAllUsers.json"

  @Inventron @Auth @Admin @AdminAuth @GetAllUsers
  Scenario: Admin Get All User in Inventron
    Given Admin admin want call an api "/login/admin" with method "POST" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    And Admin verify status code is 200
    Then Admin verify response is match with json schema "authlogin.json"
    Then Admin admin get auth token
    Given Admin admin call api "/admin/users" with method "GET"
    And Admin verify status code is 200
    Then Admin verify response is match with json schema "getAllUsers.json"

  @Inventron @Auth @Admin @AdminAuth @GetAllLocker
  Scenario: Admin Get All Locker in Inventron
    Given Admin admin want call an api "/login/admin" with method "POST" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    And Admin verify status code is 200
    Then Admin verify response is match with json schema "authlogin.json"
    Then Admin admin get auth token
    Given Admin admin call api "/admin/locker" with method "GET"
    And Admin verify status code is 200
    Then Admin verify response is match with json schema "getAllLockers.json"

  @Inventron @Auth @Admin @AdminAuth @AdminGetAllLockerSmall
  Scenario: Admin Get All Locker Medium in Inventron
    Given Admin admin want call an api "/login/admin" with method "GET" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    And Admin verify status code is 200
    Then Admin verify response is match with json schema "authlogin.json"
    Then Admin admin get auth token
    Given Admin admin call api "/admin/locker/small/1" with method "GET"
    And Admin verify status code is 200

  @Inventron @Auth @Admin @AdminAuth @AdminGetAllLockerMedium
  Scenario: Admin Get All Locker Medium in Inventron
    Given Admin admin want call an api "/login/admin" with method "GET" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    And Admin verify status code is 200
    Then Admin verify response is match with json schema "authlogin.json"
    Then Admin admin get auth token
    Given Admin admin call api "/admin/locker/medium/1" with method "GET"
    And Admin verify status code is 200

  @Inventron @Auth @Admin @AdminAuth @AdminGetAllLockerLarge
  Scenario: Admin get all locker large in API Inventron
    Given Admin admin want call an api "/login/admin" with method "POST" with payload below
      | email      | password      |
      | adminEmail | adminPassword |
    And Admin verify status code is 200
    And Admin verify response is match with json schema "authlogin.json"
    Then Admin admin get auth token
    Given Admin admin call api "/admin/locker/large/1" with method "GET"
    And Admin verify status code is 200






#
# And Admin verify response is match with json schema "getAllWarehouse.json"
    #automate ganti id
  # fixing json schema


#     Get Dashboard

#     Get All Transaction
