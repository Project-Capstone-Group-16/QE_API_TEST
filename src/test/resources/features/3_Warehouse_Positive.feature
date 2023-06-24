Feature: Warehouse Feature Positive

  @Inventron @Warehouse @Auth @GetAllWarehouse
  Scenario: User Get All Warehouse
    Given User user want call an api "/login" with method "POST" with payload below
      | email     | password     |
      | userEmail | userPassword |
    And User verify status code is 200
    And User user get auth token
    Then User verify response is match with json schema "authlogin.json"
    Then User user call an api "/warehouse" with method "GET"
    And User verify status code is 200
    Then User verify response is match with json schema "getAllWarehouse.json"

  @Inventron @Warehouse @Auth @GetAllWarehouseByStatus
  Scenario: User Get All Warehouse by status
    Given User user want call an api "/login" with method "POST" with payload below
      | email     | password     |
      | userEmail | userPassword |
    And User verify status code is 200
    And User user get auth token
    Then User verify response is match with json schema "authlogin.json"
    Then User user call an api "/warehouse?status=Available" with method "GET"
    And User verify status code is 200
    Then User verify response is match with json schema "getAllWarehouse.json"

  @Inventron @Warehouse @Auth @GetAllWarehouseByLocation
  Scenario: User Get All Warehouse By Location
    Given User user want call an api "/login" with method "POST" with payload below
      | email     | password     |
      | userEmail | userPassword |
    And User verify status code is 200
    And User user get auth token
    Then User verify response is match with json schema "authlogin.json"
    Given User user call an api "/warehouse?province=jawa timur&city=malang" with method "GET"
    And User verify status code is 200
    Then User verify response is match with json schema "getAllWarehouseByLocation.json"

  @Inventron @Warehouse @Auth @RecommendedWarehouse
  Scenario: User Get Recomended Warehouse
    Given User user want call an api "/login" with method "POST" with payload below
      | email     | password     |
      | userEmail | userPassword |
    And User verify status code is 200
    And User user get auth token
    Then User verify response is match with json schema "authlogin.json"
    Then User user call an api "/warehouse/recomended" with method "GET"
    And User verify status code is 200
    Then User verify response is match with json schema "getRecomendedWarehouse.json"