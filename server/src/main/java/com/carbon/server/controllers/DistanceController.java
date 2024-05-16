package com.carbon.server.controllers;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.carbon.server.DistanceCalculator;


@RestController
public class DistanceController {


    @GetMapping("/getDistance")
    public double getDistance(@RequestParam String start, @RequestParam String end, @RequestParam String mode) {
        return DistanceCalculator.getDistance(start, end, mode);    
    }


    @GetMapping("/getEmission")
    public double getEmission(@RequestParam String mode, @RequestParam double distance) {
        return DistanceCalculator.calculateEmission(mode, distance);
    }


    @GetMapping("/getAirports")
    public List<String> getAirports(@RequestParam String input) {
        return DistanceCalculator.getAirports(input);
    }
   
}
