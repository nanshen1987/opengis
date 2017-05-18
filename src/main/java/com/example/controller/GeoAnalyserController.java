package com.example.controller;

import com.alibaba.fastjson.JSONArray;
import com.example.service.GeoAnalyserService;
import org.apache.solr.client.solrj.SolrServerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

/**
 * Created by m on 2017/5/18.
 */
@RestController
@RequestMapping(value="/map/geoanalyzer")
public class GeoAnalyserController {

    @Autowired
    private GeoAnalyserService geoAnalyserServer;
    @RequestMapping(value="/findloc", method= RequestMethod.GET)
    public JSONArray findLoc(@RequestParam String loc,@RequestParam String name,@RequestParam double r) throws IOException, SolrServerException {
        return geoAnalyserServer.findLocation(loc,name,r);
    }
}
