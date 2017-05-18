package com.example.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.vividsolutions.jts.geom.Coordinate;
import org.apache.solr.client.solrj.SolrClient;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.geotools.geometry.jts.JTS;
import org.geotools.referencing.CRS;
import org.opengis.geometry.Geometry;
import org.opengis.referencing.FactoryException;
import org.opengis.referencing.crs.CoordinateReferenceSystem;
import org.opengis.referencing.operation.MathTransform;
import org.opengis.referencing.operation.TransformException;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.io.IOException;

/**
 * Created by m on 2017/5/18.
 */
@Service
public class GeoAnalyserService {

    public JSONArray findLocation(String location,String name,double radius) throws IOException, SolrServerException {
        String urlString = "http://localhost:8983/solr/nanjing";
        SolrClient solr = new HttpSolrClient.Builder(urlString).build();
        SolrQuery query = new SolrQuery();
        if(!StringUtils.isEmpty(name)){
            query.setQuery("name:"+name);
        }else{
            query.setQuery("*:*");
        }
        query.setFilterQueries("{!geofilt}");
        query.set("pt", location);
        query.set("sfield","geom");
        query.set("wt","json");
        query.set("d",radius+"");
        QueryResponse response = solr.query(query);
        SolrDocumentList list = response.getResults();
        JSONArray result=new JSONArray();
        for (SolrDocument solrDocument:list){
            JSONObject loc=new JSONObject();
            loc.put("name",solrDocument.get("name"));
            String orginLocStr= (String) solrDocument.get("geom");
            // 投影转换
            MathTransform transform = null;
            Coordinate target=new Coordinate();
            try {
                CoordinateReferenceSystem  crsTarget = CRS.decode("EPSG:3785");
                CoordinateReferenceSystem crsSource = CRS.decode("EPSG:4326");
                transform = CRS.findMathTransform(crsSource, crsTarget);
                Coordinate coordinate=new Coordinate(Double.parseDouble(orginLocStr.split(",")[0]),Double.parseDouble(orginLocStr.split(",")[1]));

                JTS.transform(coordinate, target,transform);
            } catch (FactoryException e) {
                e.printStackTrace();
            } catch (TransformException e) {
                e.printStackTrace();
            }
            loc.put("loc",target.getOrdinate(1)+","+target.getOrdinate(0));
            loc.put("id",solrDocument.get("id"));
            result.add(loc);
            System.out.println(solrDocument.get("name") + "," + target.getOrdinate(1) + "," + target.getOrdinate(0));
            System.out.println(solrDocument.get("name")+","+orginLocStr);
        }
        return result;
    }

}
