Feature: LockerType Feature Positive

@Inventron @User @Auth @UserGetLockerType
Scenario: User get data locker type on api inventron
  Given User user want call an api "/login" with method "POST" with payload below
  | email     | password     |
  | userEmail | userPassword |
  Then User verify status code is 200
  Then User user get auth token
  Then User verify response is match with json schema "authlogin.json"
  Given User user call an api "/lockertypes" with method "GET"
  And User verify status code is 200
  Then User verify response is match with json schema "userGetLockerType.json"