<!DOCTYPE html>
<html>
<head>
    <title>WMS 512x256 Tiles</title>
    <link rel="stylesheet" href="https://openlayers.org/en/v4.1.1/css/ol.css" type="text/css">
    <!-- The line below is only needed for old environments like Internet Explorer and Android 4.x -->
    <script src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>
    <script src="https://openlayers.org/en/v4.1.1/build/ol-debug.js"></script>
    <script type="text/javascript" src="/js/lib/jquery-3.2.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.4.3/proj4.js"></script>
    <script src="https://epsg.io/21781-1753.js"></script>
</head>
<style type="text/css">

    .half-map-left{
        width: 40%;
        height: 80%;
        float: left;
    }

    .half-map-right{
        width: 40%;
        height: 80%;
        float: right;
    }
</style>

<body>
<div style="width: 100%;height: 90%;">
<div id="map" class="half-map-left"></div>
<div id="map2" class="half-map-right"></div>
</div>
<div style="clear: both;"></div>
<input type="checkbox" style="float: none;" id="visible" checked> Toggle Layer
Visibility
<button onclick="changeTarget();">Change Target</button>
<button onclick="aninimateMap();">View Animate </button>
<script>

    var osmLayer=
            new ol.layer.Tile({
                source: new ol.source.OSM(),
                projection: 'EPSG:3857'
            });
    var layers = [

        osmLayer

    ];
    //做一次坐标转换，地图默认EPSG:3857
    var center = ol.proj.transform([118.60718267674471, 32.05703516858801],
            'EPSG:4326', 'EPSG:3857');
    var view=new ol.View({
        center: center,
        zoom: 14
    });
    var map = new ol.Map({
        layers: layers,
        target: 'map',
        renderer:'canvas',
        view: view,
    });
    //其实默认情况下，绑定同一个View他们之间就已经绑定了
    var map2 = new ol.Map({
        layers: layers,
        target: 'map2',
        renderer:'canvas',
        view: view,
    });

    function changeTarget() {
        var target = map.getTarget();
        if (target == 'map') {
            map.setTarget('map2');
        } else {
            map.setTarget('map');
        }
    };
    //动画已经交给了view，很合理，各司其职
    function aninimateMap()
    {
        map.getView().animate({zoom: 10}, {center: [0, 0]});
    }
</script>
</body>
</html>