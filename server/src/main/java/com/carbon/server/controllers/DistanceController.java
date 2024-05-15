package com.carbon.server;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DistanceController {

    @GetMapping("/getDistance")
    public double getDistance(@RequestParam String start, @RequestParam String end) {
        return DistanceCalculator.getDistance(start, end);
    }
}
