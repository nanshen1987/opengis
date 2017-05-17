<!DOCTYPE html>
<html>
<head>
    <title>WMS 512x256 Tiles</title>
    <link rel="stylesheet" href="https://openlayers.org/en/v4.1.1/css/ol.css" type="text/css">
    <!-- The line below is only needed for old environments like Internet Explorer and Android 4.x -->
    <script src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>
    <script src="https://openlayers.org/en/v4.1.1/build/ol.js"></script>
    <script type="text/javascript" src="../js/lib/jquery-3.2.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.4.3/proj4.js"></script>
    <script src="https://epsg.io/21781-1753.js"></script>
</head>
<style type="text/css">
    .contextmenu{
        position: absolute;
        top: 100%;
        width: 120px;
        height:auto;
        z-index: 9;
        background-color: #ffffff;
    }
    .contextmenu ul{
        width: 100%;
        padding: 6px 2px 0 2px;
        list-style: none;
    }
    .contextmenu > ul > li{
        width: 100%;
        text-align: center;
        padding: 5px 0;
    }
    .contextmenu > ul > li:hover{
        background-color: rgba(255, 0, 0, 0.5);
    }
</style>

<body>
<div id="contextmenu_container" class="contextmenu">
    <ul>
        <li><a href="#">设置中心</a></li>
        <li><a href="#">添加地标</a></li>
        <li><a href="#">距离丈量</a></li>
    </ul>
</div>

<div id="map" class="map"></div>
<div id="mouse-position"></div>
<script>

    var mousePositionControl = new ol.control.MousePosition({
        coordinateFormat: ol.coordinate.createStringXY(4),
        projection: 'EPSG:4326',
        // comment the following two lines to have the mouse position
        // be placed within the map.
        className: 'custom-mouse-position',
        target: document.getElementById('mouse-position'),
        undefinedHTML: '&nbsp;'
    });
    var source = new ol.source.Vector({wrapX: false});

    var vector = new ol.layer.Vector({
        source: source
    });

    var format = 'image/png';

    var layers = [
//
//        new ol.layer.Tile({
//            source: new ol.source.OSM()
//        })
//        ,
        vector,
        new ol.layer.Tile({
            visible: true,
            source: new ol.source.TileWMS({
                url: 'http://localhost:8080/geoserver/nanjing/wms',
                params: {'FORMAT': format,
                    'VERSION': '1.1.1',
                    tiled: true,
                    STYLES: '',
                    LAYERS: 'nanjing:nanjing_osm_roads',
                    tilesOrigin: 13195166.7855881 + "," +  3784739.12945354,
                    projection: 'EPSG:3785'
                }
            })
        })

    ];
    var map = new ol.Map({
        layers: layers,
        target: 'map',
        controls: ol.control.defaults({
            attributionOptions: /** @type {olx.control.AttributionOptions} */ ({
                collapsible: false
            })
        }).extend([mousePositionControl]),
        view: new ol.View({
//            projection: 'EPSG:4326',
            center: [13195166.7855881 ,  3784739.12945354],
            zoom: 14
        })
    });
    var menu_overlay = new ol.Overlay({
        element: document.getElementById("contextmenu_container"),
        positioning: 'center-center'
    });
    menu_overlay.setMap(map);
    $(map.getViewport()).on("contextmenu", function(e){
        e.preventDefault();
        var coordinate = map.getEventCoordinate(e);
        menu_overlay.setPosition(coordinate);
    });
    $(map.getViewport()).on("click", function(e){
        e.preventDefault();
        menu_overlay.setPosition(undefined);
    });
    jQuery.support.cors = true;
    function addInteraction() {
            draw = new ol.interaction.Draw({
                source: source,
                type: 'Circle',
                freehand: true
            });
            map.addInteraction(draw);
        draw.on("drawend",function(e){
            var center=e.feature.getGeometry().getCenter();
            var radius=e.feature.getGeometry().getRadius();
            var cvtPoint=ol.proj.transform(center, 'EPSG:3785','EPSG:4326');
            console.log(cvtPoint+','+radius);
            var d=radius/1000;
            var lat=cvtPoint[1];
            var lng=cvtPoint[0];
            var url='http://localhost:8983/solr/nanjing/select?d='+d+'&fq={!geofilt}&indent=on&pt='+lat+','+lng+'&q=*:*&sfield=geom&wt=json';
            $.getJSON(url,
                    {dataType: 'JSONP'},
                    function(json){
                        console.log(json);
                    }
            )
        })
    }
    addInteraction();
</script>
</body>
</html>