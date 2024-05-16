package com.carbon.server;


import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;


import java.util.ArrayList;
import java.util.List;


import org.json.JSONArray;
import org.json.JSONObject;


public class DistanceCalculator {


    private static final String API_KEY = "AIzaSyDS2lRR6DHeikTjmx9QNykRVkguSzanfSg";


    // CO2 emission factors in kg per kilometer
    private static final double CAR_EMISSION_FACTOR = 0.12;
    private static final double RAIL_EMISSION_FACTOR = 0.06;
    private static final double BUS_EMISSION_FACTOR = 0.08;
    private static final double FLIGHT_EMISSION_FACTOR = 0.18;


    public static double getDistance(String start, String end, String mode) {
        String url;
        if (mode.equals("rail")) {
            url = String.format("https://maps.googleapis.com/maps/api/directions/json?origin=%s&destination=%s&mode=transit&transit_mode=rail&key=%s", start, end, API_KEY);
        } else {
            url = String.format("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=%s&destinations=%s&mode=%s&key=%s", start, end, mode, API_KEY);
        }


        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);


        JSONObject jsonObject = new JSONObject(response.getBody());
        double distanceInMeters = jsonObject.getJSONArray("rows")
                .getJSONObject(0)
                .getJSONArray("elements")
                .getJSONObject(0)
                .getJSONObject("distance")
                .getDouble("value");


        return distanceInMeters / 1000;
    }




    // Calculate CO2 emission in kg.
    public static double calculateEmission(String mode, double distanceInKilometers) {
        double emissionFactor;
        if (mode.equals("rail")) {
            emissionFactor = RAIL_EMISSION_FACTOR;
        } else if (mode.equals("driving")) {
            emissionFactor = CAR_EMISSION_FACTOR;
        } else if (mode.equals("bus")) {
            emissionFactor = BUS_EMISSION_FACTOR;
        } else if (mode.equals("flight")) {
            emissionFactor = FLIGHT_EMISSION_FACTOR;
        } else {
            throw new IllegalArgumentException("Invalid mode: " + mode);
        }


        return distanceInKilometers * emissionFactor;
    }




    // The idea here is to get the airports from the input string.
    // This is not working as expected. The API is not returning the airports.
    // It is returning the cities.
    // The idea is to get the airports so that the user doesnt have to type the full name of the airport.
    public static List<String> getAirports(String input) {
        String url = String.format("https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%s&types=(establishment)&keyword=airport&key=%s", input, API_KEY);


        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);


        JSONObject jsonObject = new JSONObject(response.getBody());
        JSONArray predictions = jsonObject.getJSONArray("predictions");


        List<String> airports = new ArrayList<>();
        for (int i = 0; i < predictions.length(); i++) {
            airports.add(predictions.getJSONObject(i).getString("description"));
        }


        return airports;
    }


    /*
    public double getFlightDistance(String start, String end) {
        String url = String.format("https://api.aviationstack.com/v1/distances?access_key=%s&origin=%s&destination=%s", API_KEY, start, end);
   
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
   
        JSONObject jsonObject = new JSONObject(response.getBody());
        double distanceInKilometers = jsonObject.getDouble("distance");
   
        return distanceInKilometers;
    }*/


    /*
    public double calculateFlightEmission(String start, String end) {
        String url = String.format("https://api.myclimate.org/mcb.json?access_key=%s&from=%s&to=%s", API_KEY, start, end);
   
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
   
        JSONObject jsonObject = new JSONObject(response.getBody());
        double emissionInKg = jsonObject.getDouble("co2");
   
        return emissionInKg;
    }*/


}
