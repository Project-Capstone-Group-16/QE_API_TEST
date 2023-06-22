Feature: Upload Image

  @Inventron @User @Admin @UploadImage
  Scenario: User create favorite warehouse
    Given Admin call api "/upload/image" method "POST"
    Then User verify status code is 200