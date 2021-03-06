<!doctype html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://openlayers.org/en/v4.1.1/css/ol.css" type="text/css">
    <style>
        .map {
            height: 95%;
            width: 100%;
        }
    </style>
    <script src="https://openlayers.org/en/v4.1.1/build/ol.js" type="text/javascript"></script>
    <title>OpenLayers example</title>
</head>
<body>
<div id="map" class="map"></div>
<script type="text/javascript">
    var map = new ol.Map({
        target: 'map',
        layers: [
            new ol.layer.Tile({
                source: new ol.source.OSM()
            })
        ],
        view: new ol.View({
            center: ol.proj.fromLonLat([118.7732,31.9973 ]),
            zoom: 15
        })
    });
</script>
</body>
</html>
