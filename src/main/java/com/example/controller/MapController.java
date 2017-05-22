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

    @RequestMapping(value = "/openlayer/basic",method = RequestMethod.GET)
    public String mapBasic()
    {
        return "map/openlayer/basic";
    }
    @RequestMapping(value = "/openlayer/raster",method = RequestMethod.GET)
    public String mapRaster()
    {
        return "map/openlayer/raster";
    }

    @RequestMapping(value = "/openlayer/vector",method = RequestMethod.GET)
    public String mapVector()
    {
        return "map/openlayer/vector";
    }


}
