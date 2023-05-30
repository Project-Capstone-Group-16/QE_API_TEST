package starter.stepdefinitions;

import com.github.javafaker.Faker;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
//import io.cucumber.java.en.And;
import io.restassured.RestAssured;
import io.restassured.response.Response;
import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.rest.abilities.CallAnApi;
import net.serenitybdd.screenplay.rest.interactions.*;
//import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import starter.data.Admin;
import starter.data.User;

//import java.util.ArrayList;
import java.io.File;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import static io.restassured.module.jsv.JsonSchemaValidator.matchesJsonSchemaInClasspath;
//import static org.hamcrest.Matchers.emptyString;
//import static org.hamcrest.Matchers.not;

public class APIStepDefinitions {

    String baseURL = "http://143.198.92.250:8080";

    User user = new User();
    Admin admin = new Admin();

    @Given("{actor} call an api {string} with method {string} with payload below")
    public void callApi(Actor actor, String path, String method, DataTable table) {
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
                    user.setEmail(randomEmail);
                    admin.setAdminEmail(randomEmail);
                }
                case "randomPassword" -> {
                    String randomPassword = faker.internet().password();
                    bodyRequest.put(key, randomPassword);
                    admin.setAdminPassword(randomPassword);
                }
                case "randomFullname" -> {
                    String randomFullname = faker.name().fullName();
                    bodyRequest.put(key, randomFullname);
                    admin.setAdminPassword(randomFullname);
                }

                case "userEmail" -> bodyRequest.put(key, user.getEmail());
                case "adminEmail" -> bodyRequest.put(key, admin.getAdminEmail());
                case "userPassword" -> bodyRequest.put(key, user.getPassword());
                case "adminPassword" -> bodyRequest.put(key, admin.getAdminPassword());
                case "registPassword" -> bodyRequest.put(key, user.getPassword());
//                case "userOtp" -> bodyRequest.put(key, user.getOtp());
                default -> bodyRequest.put(key, valueList.get(key));
            }
        }

        switch (method) {
            case "GET":
                actor.attemptsTo(Get.resource(path));
                break;
            case "POST":
                actor.attemptsTo(Post.to(path).with(request -> request.body(bodyRequest)));
                break;
            case "PATCH":
                actor.attemptsTo(Patch.to(path));
                break;
            case "PUT":
                actor.attemptsTo(Put.to(path));
                break;
            case "DELETE":
                actor.attemptsTo(Delete.from(path));
                break;
            default:
                throw new IllegalStateException("Unknown method");
        }
    }

    @Given("{actor} call an api {string} with method {string}")
    public void callApi(Actor actor, String path, String method) {
        actor.whoCan(CallAnApi.at(baseURL));

        switch (method) {
            case "GET":
                actor.attemptsTo(Get.resource(path));
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
                actor.attemptsTo(Delete.from(path));
                break;
            default:
                throw new IllegalStateException("Unknown method");
        }
    }

//    @Given("{actor} generate some otp")
//    public void userGenerateSomeOtp(Actor actor) {
//        actor.whoCan(CallAnApi.at(baseURL));
//
//        JSONObject bodyRequest = new JSONObject();
//
//        bodyRequest.put("email", "arulbeka25@gmail.com");
//
//        actor.attemptsTo(Post.to("/forgot-password/generate")
//                .with(request -> request.body(bodyRequest).log().all());
//    }

//    @Given("{actor} verify some otp")
//    public void userVerifySomeOtp(Actor actor) {
//        actor.whoCan(CallAnApi.at(baseURL));
//
//        JSONObject bodyRequest = new JSONObject();
//
//        bodyRequest.put("otp", "946189");
//
//        actor.attemptsTo(Post.to("/forgot-password/verify")
//                .with(request -> request.body(bodyRequest).log().all());
//    }

//    @Given("{actor} update password account")
//    public void userUpdatePasswordAccount(Actor actor) {
//        actor.whoCan(CallAnApi.at(baseURL));
//
//        JSONObject bodyRequest = new JSONObject();
//
//        bodyRequest.put("password" , "subaruputra1313");
//        bodyRequest.put("confirm_password" , "subaruputra1313");
//
//        actor.attemptsTo(Post.to("/forgot-password/verify")
//                .with(request -> request.body(bodyRequest).log().all());
//    }


    @Then("{actor} verify response is match with json schema {string}")
    public void userVerifyResponseIsMatchWithJsonSchema(Actor actor, String schema) {
        Response response = SerenityRest.lastResponse();
        response.then().body(matchesJsonSchemaInClasspath(schema));
        System.out.println(admin.getAuth());
    }

    @Then("{actor} verify status code is {int}")
    public void userVerifyStatusCodeIs(Actor actor, int statusCode) {
        Response response = SerenityRest.lastResponse();
        response.then().statusCode(statusCode).log().all();
    }

    @Then("{actor} get auth token")
    public void adminGetAuth(Actor actor) {
        Response response = SerenityRest.lastResponse();
        admin.setAuth(response.path("data.token"));
    }

    @Given("{actor} call api {string} with method {string}")
    public void userCallApiWithMethod(Actor actor, String path, String method) {
        actor.whoCan(CallAnApi.at(baseURL));

        switch (method) {
            case "GET" ->
                    actor.attemptsTo(Get.resource(path).with(request -> request.header("Authorization", "Bearer " + admin.getAuth())));
            case "POST" -> actor.attemptsTo(Post.to(path));
            case "PUT" -> actor.attemptsTo(Put.to(path));
            case "DELETE" -> actor.attemptsTo(Delete.from(path).with(request -> request.header("Authorization", "Bearer " + admin.getAuth())));
            default -> throw new IllegalStateException("Unknown method");
        }
        System.out.println(admin.getAuth());
    }

    @Given("{actor} create warehouse {string}")
    public void adminCreateWarehouse(Actor actor, String path) {
        actor.whoCan(CallAnApi.at(baseURL));

        Faker faker = new Faker(new Locale("in-ID"));
        String nameWarehouse = "Inventron" + faker.address().city();
        String location = faker.address().city();

        File file = new File("C:/Users/My Windows/Pictures/After/DSC02390.jpg");

        Response response = RestAssured
                .given()
//                .formParam("token", admin.getToken())
                .multiPart("name", nameWarehouse, "multipart/form-data")
                .multiPart("location", location, "multipart/form-data")
                .multiPart("warehouse_image", file, "multipart/form-data")
                .when()
                .post();

        actor.attemptsTo(Post.to(path).with(request -> request.header("Authorization", "Bearer " + admin.getAuth()).body(response)));
        System.out.println(admin.getAuth());

    }

//    @And("{actor} get auth token")
//    public void userGetAuthToken(Actor actor){
//        Response response = SerenityRest.lastResponse();
//        user.setToken(response.path("data"));
//    }


}
