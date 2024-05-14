package com.carbon.server;

import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;
import org.json.JSONObject;

public class DistanceCalculator {

    private static final String API_KEY = "AIzaSyDS2lRR6DHeikTjmx9QNykRVkguSzanfSg";

    public static double getDistance(String start, String end) {
        String url = String.format("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=%s&destinations=%s&key=%s", start, end, API_KEY);
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
    
        JSONObject jsonObject = new JSONObject(response.getBody());
        double distanceInMeters = jsonObject.getJSONArray("rows")
                .getJSONObject(0)
                .getJSONArray("elements")
                .getJSONObject(0)
                .getJSONObject("distance")
                .getDouble("value");
        
        double distanceInKilometers = distanceInMeters / 1000;
    
        return distanceInKilometers;
    }


    public static void main(String[] args) {
        String start = "Stockholm,Sweden";
        String end = "Gothenburg,Sweden";
        double distance = getDistance(start, end);
        System.out.println("The distance from " + start + " to " + end + " is " + distance + " Km.");
    }
}