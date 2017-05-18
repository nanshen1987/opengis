package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by m on 2017/5/4.
 */

@Controller
@RequestMapping("/map")
public class MapController {

    @RequestMapping("/openstreet")
    public String openStreetMap()
    {
        return "map/openstreet";
    }
    @RequestMapping(value = "/geoserver",method = RequestMethod.GET)
    public String geoServerMap()
    {
        return "map/geoserver";
    }

}
