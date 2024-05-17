package com.carbon.server;


import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;


public class DistanceCalculator {


    private static final String API_KEY = "AIzaSyDS2lRR6DHeikTjmx9QNykRVkguSzanfSg";
    private static final String carbon_API_KEY = "SFbhbVU5vEAQaKuBqAdXg";


    // CO2 emission factors in kg per kilometer
    private static final double CAR_EMISSION_FACTOR = 0.12;
    private static final double RAIL_EMISSION_FACTOR = 0.06;
    private static final double BUS_EMISSION_FACTOR = 0.08;
    private static Map<String, Double> flightData = new HashMap<>();


    public static double getDistance(String start, String end, String mode) {
        String url;
        if (mode.equals("flight")) {
            flightData = getFlightEmissionAndDistance(start, end);
            return flightData.getOrDefault("distance", 0.0);
        } else if (mode.equals("rail")) {
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
            return flightData.getOrDefault("carbon_kg", 0.0);
        } else {
            throw new IllegalArgumentException("Invalid mode: " + mode);
        }


        return distanceInKilometers * emissionFactor;
    }




    // The idea here is to get the airports from the input string.
    // The airports are stored in a CSV file.
    // The CSV file is read and the airports are filtered based on the input string.
    public static List<String> getAirports(String input) {
        List<String> airports = new ArrayList<>();
    
        try (BufferedReader reader = new BufferedReader(new FileReader("src/main/java/com/carbon/server/airports.csv"))) {
            String line = reader.readLine(); // read the first line with column names
            String[] columnNames = line.split(",");
    
            while ((line = reader.readLine()) != null) {
                String[] fields = line.split(",");
                Map<String, String> airport = new HashMap<>();
                for (int i = 0; i < columnNames.length && i < fields.length; i++) {
                    airport.put(columnNames[i].replace("\"", ""), fields[i].replace("\"", ""));
                }
    
                String city = airport.get("city");
                String name = airport.get("name");
    
                if (city != null && city.toLowerCase().contains(input.toLowerCase()) ||
                    name != null && name.toLowerCase().contains(input.toLowerCase())) {
                    String result = String.format("%s, %s, %s", airport.get("code"), city, name);
                    airports.add(result);
                }
            }
        } catch (IOException e) {
            System.out.println("Error getting airports: " + e.getMessage());
            e.printStackTrace();
        }
    
        return airports;
    }


    /**
     * Get flight emission and distance from the carbion interface API
     * This api is very accurate and provides the most accurate data for flight emissions that I could find.

     * @param start Departure airport code.
     * @param end Destination airport code.
     * @return A map with the carbon emission in kg and the distance in km.
     */
    public static Map<String, Double> getFlightEmissionAndDistance(String start, String end) {  
        try {
            String estimatesUrl = "https://www.carboninterface.com/api/v1/estimates";
            RestTemplate restTemplate = new RestTemplate();
            HttpHeaders estimatesHeaders = new HttpHeaders();
            estimatesHeaders.setContentType(MediaType.APPLICATION_JSON);
            estimatesHeaders.set("Authorization", "Bearer " + carbon_API_KEY);
            JSONObject requestBody = new JSONObject();
            requestBody.put("type", "flight");
            requestBody.put("passengers", 1);
            requestBody.put("legs", new JSONArray()
                .put(new JSONObject()
                    .put("departure_airport", start)
                    .put("destination_airport", end)));
            HttpEntity<String> estimatesRequest = new HttpEntity<>(requestBody.toString(), estimatesHeaders);
            ResponseEntity<String> estimatesResponse = restTemplate.postForEntity(estimatesUrl, estimatesRequest, String.class);
    
            JSONObject jsonObject = new JSONObject(estimatesResponse.getBody()).getJSONObject("data").getJSONObject("attributes");
            Map<String, Double> result = new HashMap<>();
            result.put("carbon_kg", jsonObject.getDouble("carbon_kg"));
            result.put("distance", jsonObject.getDouble("distance_value"));
    
            return result;
        } catch (Exception e) {
            System.out.println("Error getting flight emission and distance: " + e.getMessage());
            e.printStackTrace();
            return Collections.emptyMap();
        }
    }

}
