package starter.stepdefinitions;

import com.github.javafaker.Faker;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
//import io.cucumber.java.en.And;
import io.restassured.response.Response;
import net.serenitybdd.rest.SerenityRest;
import net.serenitybdd.screenplay.Actor;
import net.serenitybdd.screenplay.rest.abilities.CallAnApi;
import net.serenitybdd.screenplay.rest.interactions.*;
//import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import starter.data.User;

//import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import static io.restassured.module.jsv.JsonSchemaValidator.matchesJsonSchemaInClasspath;
//import static org.hamcrest.Matchers.emptyString;
//import static org.hamcrest.Matchers.not;

public class APIStepDefinitions {

    String baseURL = "http://3.25.202.31:8080";

    User user = new User();

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
                }

                case "userEmail" -> bodyRequest.put(key, user.getEmail());
                case "userPassword" -> bodyRequest.put(key, user.getPassword());
                case "registPassword" -> bodyRequest.put(key, user.getRegistPassword());
//                case "userOtp" -> bodyRequest.put(key, user.getOtp());
                default -> bodyRequest.put(key, valueList.get(key));
            }
        }

        switch (method) {
            case "GET":
                actor.attemptsTo(Get.resource(path));
                break;
            case "POST":
                actor.attemptsTo(Post.to(path).with(request -> request.body(bodyRequest).log().all()));
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
    }

    @Then("{actor} verify status code is {int}")
    public void userVerifyStatusCodeIs(Actor actor, int statusCode) {
        Response response = SerenityRest.lastResponse();
        response.then().statusCode(statusCode).log().all();
    }

//    @And("{actor} get auth token")
//    public void userGetAuthToken(Actor actor){
//        Response response = SerenityRest.lastResponse();
//        user.setToken(response.path("data"));
//    }


//METHOD YANG DIPAKE CUMAN DIATAS DOANG

//METHOD DIBAWAH DUMMY DOANG YANG DIPAKE PAS CAPSTONE
//
//    @Then("{actor} verify {string} is exist")
//    public void userVerifyIsExist(Actor actor, String data) {
//        Response response = SerenityRest.lastResponse();
//        response.then().body(data, not(emptyString()));
//    }
//
//
//
//    @Given("{actor} get other users informations")
//    public void getOtherUsersInformations(Actor actor) {
//        actor.whoCan(CallAnApi.at(baseURL));
//        actor.attemptsTo(Get.resource("/auth/info")
//                .with(request -> request.header("Authorization", "Bearer "+user.getToken()).log().all()));
//    }
//
//    @Given("{actor} is create a new product")
//    public void userIsCreateANewProduct(Actor actor){
//        Faker faker = new Faker(new Locale("in-ID"));
//
//        actor.whoCan(CallAnApi.at(baseURL));
//
//        JSONObject bodyRequest = new JSONObject();
//
//        List<Integer> listCategories = new ArrayList<>();
//        listCategories.add(0, 8822);
//        listCategories.add(1, 5938);
//        listCategories.add(2, 5939);
//
//        bodyRequest.put("name", faker.commerce().productName());
//        bodyRequest.put("description", faker.lorem().sentence());
//        bodyRequest.put("price", 100);
//        bodyRequest.put("categories", listCategories);
//
//        actor.attemptsTo(Post.to("/products").with(request -> request.header("Authorization", user.getToken()).body(bodyRequest).log().all()));
//    }
//
//
//    @Given("{actor} input a product rating")
//    public void userInputAProductRating(Actor actor) {
//        actor.whoCan(CallAnApi.at(baseURL));
//
//        JSONObject bodyRequest = new JSONObject();
//
//        bodyRequest.put("count", 5);
//
//        actor.attemptsTo(Post.to("/products/14340/ratings")
//                .with(request -> request.header("Authorization", "Bearer "+user.getToken())
//                        .body(bodyRequest).log().all()));
//    }
//
//    @Given("{actor} create a comment on product")
//    public void userCreateACommentOnProduct(Actor actor) {
//        actor.whoCan(CallAnApi.at(baseURL));
//
//        JSONObject bodyRequest = new JSONObject();
//
//        bodyRequest.put("content", "ini testing dibuat sama arul budi kalimat 25 04 2002");
//
//        actor.attemptsTo(Post.to("/products/14340/comments")
//                .with(request -> request.header("Authorization", "Bearer "+user.getToken())
//                        .body(bodyRequest).log().all()));
//    }
//
//    @Given("{actor} is create new category products")
//    public void userIsCreateNewCategoryProducts(Actor actor) {
//        actor.whoCan(CallAnApi.at(baseURL));
//
//        JSONObject bodyRequest = new JSONObject();
//
//        bodyRequest.put("name", "Peripheral Gaming");
//        bodyRequest.put("description", "Mouse, Keyboard, Headphone ETC");
//
//        actor.attemptsTo(Post.to("/categories")
//                .with(request -> request.header("Authorization", "Bearer "+user.getToken())
//                        .body(bodyRequest).log().all()));
//    }
//
//    @Given("{actor} create a new orders")
//    public void userCreateOrders(Actor actor) {
//        actor.whoCan(CallAnApi.at(baseURL));
//
//        JSONArray bodyRequest = new JSONArray();
//        JSONObject order1 = new JSONObject();
//        {
//            order1.put("product_id", 14340);
//            order1.put("quantity", 1);
//            bodyRequest.add(order1);
//
//            actor.attemptsTo(Post.to("/orders")
//                    .with(request -> request.header("Authorization", "Bearer " + user.getToken())
//                            .body(bodyRequest).log().all()));
//        }
//    }
//
//    @Given("{actor} get all orders")
//    public void userGetAllOrders (Actor actor) {
//        actor.whoCan(CallAnApi.at(baseURL));
//        actor.attemptsTo(Get.resource("/orders")
//                .with(request -> request.header("Authorization", "Bearer "+user.getToken()).log().all()));
//    }
//
//    @Given("{actor} get all orders by id")
//    public void userGetAllOrdersById(Actor actor) {
//        actor.whoCan(CallAnApi.at(baseURL));
//        actor.attemptsTo(Get.resource("/orders/11014")
//                .with(request -> request.header("Authorization", "Bearer "+user.getToken()).log().all()));
//    }

}
