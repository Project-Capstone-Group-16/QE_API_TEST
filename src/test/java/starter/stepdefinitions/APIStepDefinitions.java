package starter.stepdefinitions;

import com.github.javafaker.Faker;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.rest.abilities.CallAnApi;
import net.serenitybdd.screenplay.rest.interactions.*;
import org.jetbrains.annotations.NotNull;
import org.json.simple.JSONObject;
import starter.data.Admin;
import starter.data.ID;
import starter.data.Jabatan;
import starter.data.User;

import java.io.File;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import static io.restassured.module.jsv.JsonSchemaValidator.matchesJsonSchemaInClasspath;

public class APIStepDefinitions {

    String baseURL = "http://143.198.92.250:8080";

    User user = new User();
    Admin admin = new Admin();

    Jabatan jabatan = new Jabatan();
    ID id = new ID();

    @Given("{actor} user want call an api {string} with method {string} with payload below")
    public void callApiAsUserPayload(Actor actor, String path, String method, DataTable table) {
        actor.whoCan(CallAnApi.at(baseURL));

        // Create request body json instance
        JSONObject bodyRequest = new JSONObject();

        // Get headers
        List<List<String>> rowsList = table.asLists(String.class);
        List<String> headerList = rowsList.get(0);

        // Get values
        List<Map<String, String>> rowsMap = table.asMaps(String.class, String.class);
        Map<String, String> valueList = rowsMap.get(0);

        // Loop on every values and set value with key from header to request body
        for (int i = 0; i < valueList.size(); i++) {
            Faker faker = new Faker(new Locale("in-ID"));

            String key = headerList.get(i);

            //check if value correspond to random syntax
            switch (valueList.get(key)) {

                case "randomUserEmail" -> {
                    String randomEmail = faker.internet().emailAddress();
                    bodyRequest.put(key, randomEmail);
                    user.setUserEmail(randomEmail);
                }
                case "randomUserPassword" -> {
                    String randomPassword = faker.internet().password();
                    bodyRequest.put(key, randomPassword);
                    user.setUserPassword(randomPassword);
                }
                case "randomFullname" -> {
                    String randomFullname = faker.name().fullName();
                    bodyRequest.put(key, randomFullname);
                }
                case "randomFirstname" -> {
                    String randomFirstname = faker.name().firstName();
                    bodyRequest.put(key, randomFirstname);
                }
                case "randomLastname" -> {
                    String randomLastname = faker.name().lastName();
                    bodyRequest.put(key, randomLastname);
                }
                case "randomAddress" -> {
                    String randomAddress = faker.address().fullAddress();
                    bodyRequest.put(key, randomAddress);
                }
                case "imageUrl" -> {
                    String imageUrl = faker.internet().avatar();
                    bodyRequest.put(key, imageUrl);
                }
                case "favoriteWarehouse" -> {
                    int favoriteWarehouse = 1;
                    bodyRequest.put(key, favoriteWarehouse);
                }
                case "gender" -> bodyRequest.put(key, jabatan.forGender());
                case "userEmail" -> bodyRequest.put(key, user.getUserEmail());
                case "userPassword" -> bodyRequest.put(key, user.getUserPassword());
                default -> bodyRequest.put(key, valueList.get(key));
            }
        }

        switch (method) {
            case "GET" ->
                    actor.attemptsTo(Get.resource(path).with(request -> request.header("Authorization", "Bearer " + user.getAuth())));
            case "POST" ->
                    actor.attemptsTo(Post.to(path).with(request -> request.header("Authorization", "Bearer " + user.getAuth()).body(bodyRequest)));
            case "PATCH" -> actor.attemptsTo(Patch.to(path));
            case "PUT" ->
                    actor.attemptsTo(Put.to(path).with(request -> request.header("Authorization", "Bearer " + user.getAuth()).body(bodyRequest)));
            case "DELETE" -> actor.attemptsTo(Delete.from(path));
            default -> throw new IllegalStateException("Unknown method");
        }
    }

    @Given("{actor} user call an api {string} with method {string}")
    public void callApiAsUser(Actor actor, String path, String method) {
        actor.whoCan(CallAnApi.at(baseURL));

        switch (method) {
            case "GET" ->
                    actor.attemptsTo(Get.resource(path).with(request -> request.header("Authorization", "Bearer " + user.getAuth())));
            case "POST" -> actor.attemptsTo(Post.to(path));
            case "PUT" -> actor.attemptsTo(Put.to(path));
            case "PATCH" -> actor.attemptsTo(Patch.to(path));
            case "DELETE" -> actor.attemptsTo(Delete.from(path));
            default -> throw new IllegalStateException("Unknown method");
        }
    }

    @Given("{actor} admin want call an api {string} with method {string} with payload below")
    public void callApiAsAdminPayload(Actor actor, String path, String method, DataTable table) {
        actor.whoCan(CallAnApi.at(baseURL));

        // Create request body json instance
        JSONObject bodyRequest = new JSONObject();

        // Get headers
        List<List<String>> rowsList = table.asLists(String.class);
        List<String> headerList = rowsList.get(0);

        // Get values
        List<Map<String, String>> rowsMap = table.asMaps(String.class, String.class);
        Map<String, String> valueList = rowsMap.get(0);

        // Loop on every values and set value with key from header to request body
        for (int i = 0; i < valueList.size(); i++) {
            Faker faker = new Faker(new Locale("in-ID"));


            String key = headerList.get(i);

            //check if value correspond to random syntax
            switch (valueList.get(key)) {

                case "randomEmail" -> {
                    String randomEmail = faker.internet().emailAddress();
                    bodyRequest.put(key, randomEmail);
                    admin.setAdminEmail(randomEmail);
                }
                case "randomPassword" -> {
                    String randomPassword = faker.internet().password();
                    bodyRequest.put(key, randomPassword);
                    admin.setAdminPassword(randomPassword);
                }
                case "randomFirstname" -> {
                    String randomFirstname = faker.name().firstName();
                    bodyRequest.put(key, randomFirstname);
                }
                case "randomLastname" -> {
                    String randomLastname = faker.name().lastName();
                    bodyRequest.put(key, randomLastname);
                }
                case "randomFullname" -> {
                    String randomFullname = faker.name().fullName();
                    bodyRequest.put(key, randomFullname);
                }
                case "randomAddress" -> {
                    String randomAddress = faker.address().fullAddress();
                    bodyRequest.put(key, randomAddress);
                }
                case "nameWarehouse" -> {
                    String location = faker.address().city();
                    bodyRequest.put(key, "Inventron " + location);
                    admin.setLocation(location);
                }
                case "cityWarehouse" -> bodyRequest.put(key, admin.getLocation());

                case "descriptionWarehouse" -> {
                    String description = faker.lorem().sentence();
                    bodyRequest.put(key, description);
                }

                case "posision" -> bodyRequest.put(key, jabatan.forPosision());
                case "gender" -> bodyRequest.put(key, jabatan.forGender());
                case "imageUrl" -> bodyRequest.put(key, faker.internet().avatar());
                case "adminEmail" -> bodyRequest.put(key, admin.getAdminEmail());
                case "adminPassword" -> bodyRequest.put(key, admin.getAdminPassword());
                default -> bodyRequest.put(key, valueList.get(key));
            }
        }

        switch (method) {
            case "GET":
                actor.attemptsTo(Get.resource(path));
                break;
            case "POST":
                actor.attemptsTo(Post.to(path).with(request -> request.header("Authorization", "Bearer " + admin.getAuth()).body(bodyRequest).log().all()));
                break;
            case "PATCH":
                actor.attemptsTo(Patch.to(path));
                break;
            case "PUT":
                actor.attemptsTo(Put.to(path).with(request -> request.header("Authorization", "Bearer " + admin.getAuth()).body(bodyRequest).log().all()));
                break;
            case "DELETE":
                actor.attemptsTo(Delete.from(path));
                break;
            default:
                throw new IllegalStateException("Unknown method");
        }
    }

    @Given("{actor} admin call api {string} with method {string}")
    public void callApiAsAdmin(Actor actor, String path, String method) {
        actor.whoCan(CallAnApi.at(baseURL));

        switch (method) {
            case "GET":
                actor.attemptsTo(Get.resource(path).with(request -> request.header("Authorization", "Bearer " + admin.getAuth())));
                break;
            case "POST":
                actor.attemptsTo(Post.to(path));
                break;
            case "PUT":
                actor.attemptsTo(Put.to(path));
                break;
            case "PATCH":
                actor.attemptsTo(Patch.to(path));
                break;
            case "DELETE":
                actor.attemptsTo(Delete.from(path).with(request -> request.header("Authorization", "Bearer " + admin.getAuth())));
                break;
            default:
                throw new IllegalStateException("Unknown method");
        }
    }

    @Then("{actor} verify response is match with json schema {string}")
    public void userVerifyResponseIsMatchWithJsonSchema(Actor actor, String schema) {
        Response response = SerenityRest.lastResponse();
        response.then().body(matchesJsonSchemaInClasspath(schema));
    }

    @Then("{actor} verify status code is {int}")
    public void userVerifyStatusCodeIs(Actor actor, int statusCode) {
        Response response = SerenityRest.lastResponse();
        response.then().statusCode(statusCode).log().all();
    }

    @Then("{actor} admin get auth token")
    public void adminGetAuth(Actor actor) {
        Response response = SerenityRest.lastResponse();
        admin.setAuth(response.path("data.token"));

        System.out.println(admin.getAuth());
    }

    @Then("{actor} user get auth token")
    public void userGetAuth(Actor actor) {
        Response response = SerenityRest.lastResponse();
        user.setAuth(response.path("data.token"));
        response.then().log().all();
    }

    @Given("{actor} want favorite warehouse path {string} with method {string}")
    public void userWantFavoriteWarehouseWithMethod(Actor actor, String path, String method) {
        actor.whoCan(CallAnApi.at(baseURL));

        JSONObject bodyrequest = new JSONObject();

        bodyrequest.put("warehouse_id", 1);

        if (method.equals("POST")) {
            actor.attemptsTo(Post.to(path).with(request -> request.header("Authorization", "Bearer " + user.getAuth()).body(bodyrequest)));
        } else {
            throw new IllegalStateException("Unknown method");
        }
    }

    @And("{actor} automate get id {string}")
    public void adminAutomateGetId(Actor actor, String type) {
        actor.whoCan(CallAnApi.at(baseURL));

        String pathWarehouse = "/admin/warehouse";
        String pathStaff = "/admin/staff";

        Response response = SerenityRest.lastResponse();

        JsonPath jsonPath = new JsonPath(response.asString());

        int zip = jsonPath.getInt("data[0].id");

        switch (type) {
            case "warehouse" -> {
                actor.attemptsTo(Get.resource(pathWarehouse).with(request -> request.header("Authorization", "Bearer " + admin.getAuth())));
                id.setIdWarehouse(response.path(String.valueOf(zip)));
                System.out.println(id.getIdWarehouse());
            }
            case "staff" -> {
                actor.attemptsTo(Get.resource(pathStaff).with(request -> request.header("Authorization", "Bearer " + admin.getAuth())));
                id.setIdStaff(response.path("data.token"));
                System.out.println(id.getIdStaff());
            }
        }

    }

    @Given("{actor} want make transaction path {string} with method {string}")
    public void guserWantMakeTransactionPathWithMethod(Actor actor, String path, String method) {
        actor.whoCan(CallAnApi.at(baseURL));

        JSONObject bodyrequest = new JSONObject();

        bodyrequest.put("warehouse_id", 1);
        bodyrequest.put("locker_type_id", 3);
        bodyrequest.put("item_category_id", 1);
        bodyrequest.put("start_date", "13/06/2023");
        bodyrequest.put("end_date", "23/06/2023");

        if (method.equals("POST")) {
            actor.attemptsTo(Post.to(path).with(request -> request.header("Authorization", "Bearer " + user.getAuth()).body(bodyrequest)));
        } else {
            throw new IllegalStateException("Unknown method");
        }
    }

    @Given("{actor} want GET all small locker {string} with method {string}")
    public void UserWantGETalllockersmall(Actor actor, String path, String method) {
        actor.whoCan(CallAnApi.at(baseURL));
        actor.attemptsTo(Get.resource(path).with(request -> request.header("Authorization", "Bearer " + admin.getAuth())));
        JSONObject bodyrequest = new JSONObject();
    }

    @Given("{actor} want GET all medium locker {string} with method {string}")
    public void UserWantGETalllockermedium(Actor actor, String path, String method) {
        actor.whoCan(CallAnApi.at(baseURL));
        actor.attemptsTo(Get.resource(path).with(request -> request.header("Authorization", "Bearer " + admin.getAuth())));
        JSONObject bodyrequest = new JSONObject();
    }


    @Given("{actor} GET favorite in inventron {string} with method {string}")
    public void UserWantGETfavoriteInInventron(Actor actor, String path, String method) {
        actor.whoCan(CallAnApi.at(baseURL));
        actor.attemptsTo(Get.resource(path).with(request -> request.header("Authorization", "Bearer " + admin.getAuth())));
        JSONObject bodyrequest = new JSONObject();
    }

    @Given("{actor} GET all transaction in inventron {string} with method {string}")
    public void UserWantGETallTransaction(Actor actor, String path, String method) {
        actor.whoCan(CallAnApi.at(baseURL));
        actor.attemptsTo(Get.resource(path).with(request -> request.header("Authorization", "Bearer " + admin.getAuth())));
        JSONObject bodyrequest = new JSONObject();
    }

}

// @Given("{actor} admin call api {string} with method {string}")
//    public void userCallApiWithMethod(Actor actor, String path, String method) {
//        actor.whoCan(CallAnApi.at(baseURL));
//
//        Faker faker = new Faker(new Locale("in-ID"));
//        String location = faker.address().city();
//        String nameWarehouse = "Inventron " + location;
//
//        File file = new File(System.getProperty("user.dir") + "/src/test/resources/img/warehouse.jpg");
//
//        switch (method) {
//            case "GET" ->
//                    actor.attemptsTo(Get.resource(path).with(request -> request.header("Authorization", "Bearer " + admin.getAuth())));
//
//            case "POST" -> actor.attemptsTo(Post.to(path).with(request -> request.contentType("multipart/form-data").header("Authorization", "Bearer " + admin.getAuth())
//                    .multiPart("name", nameWarehouse).multiPart("location", location).multiPart("warehouse_image", file,"image/jpeg")));
//
//            case "PUT" -> actor.attemptsTo(Put.to(path).with(request -> request.contentType("multipart/form-data").header("Authorization", "Bearer " + admin.getAuth())
//                    .multiPart("name", nameWarehouse).multiPart("location", location).multiPart("status", "Not Available").multiPart("warehouse_image", file,"image/jpeg")));
//
//            case "DELETE" -> actor.attemptsTo(Delete.from(path).with(request -> request.header("Authorization", "Bearer " + admin.getAuth())));
//
//            default -> throw new IllegalStateException("Unknown method");
//        }
//    }
