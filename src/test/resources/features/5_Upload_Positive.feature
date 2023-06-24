Feature: Upload Image

  @Inventron @User @Admin @UploadImage
  Scenario: User and Admin
    Given Admin call api "/upload/image" method "POST"
    Then Admin verify status code is 200