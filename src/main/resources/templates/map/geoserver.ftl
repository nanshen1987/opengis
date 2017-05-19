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
    .map {
        height: 800px;
        width: 100%;
        background-color: #b5d0d0;
    }

    .contextmenu {
        position: absolute;
        top: 100%;
        width: 120px;
        height: auto;
        z-index: 9;
        background-color: #ffffff;
    }

    .contextmenu ul {
        width: 100%;
        padding: 6px 2px 0 2px;
        list-style: none;
    }

    .contextmenu > ul > li {
        width: 100%;
        text-align: center;
        padding: 5px 0;
    }

    .contextmenu > ul > li:hover {
        background-color: rgba(255, 0, 0, 0.5);
    }

    .marker {
        width: 20px;
        height: 20px;
        border: 1px solid #088;
        border-radius: 10px;
        background-color: #0FF;
        opacity: 0.5;
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
<div>
    <div class="marker" title="Marker"></div>
</div>
<div id="map" class="map"></div>
<div id="mouse-position"></div>
<div>
    <button onclick="addInteraction()">enable</button>
    <button onclick="removeInteraction()">disable</button>
    <button onclick="clearAll()">clearAll</button>
    <label>名称：</label><input id="name"/>
    <input type="checkbox" id="visible" checked> Toggle Layer
    Visibility
</div>
<div id="overlay" style="background-color: white; border-radius:
10px; border: 1px solid black; padding: 5px 10px;">
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

    var interaction = new ol.interaction.DragRotateAndZoom();
    var interactions = ol.interaction.defaults().extend([interaction]);
    var control = new ol.control.FullScreen();
    var zoomCtl=new ol.control.Zoom();
    var overlay = new ol.Overlay({
        element: document.getElementById('overlay'),
        positioning: 'bottom-center'
    });

    var format = 'image/png';
    var osmLayer=
            new ol.layer.Tile({
                source: new ol.source.OSM(),
                projection: 'EPSG:3857'
            });

    var layers = [

        osmLayer
        ,

        new ol.layer.Tile({
            visible: true,
            source: new ol.source.TileWMS({
                url: 'http://localhost:8080/geoserver/nanjing/wms',
                params: {
                    'FORMAT': format,
                    'VERSION': '1.1.1',
                    tiled: true,
                    STYLES: '',
                    LAYERS: 'nanjing:nanjing_osm_roads',
//                    tilesOrigin: 13195166.7855881 + "," +  3784739.12945354,
                }
            })
        }),
        vector

    ];
    //做一次坐标转换，地图默认EPSG:3857
    var center = ol.proj.transform([118.60718267674471, 32.05703516858801],
            'EPSG:4326', 'EPSG:3857');
    var map = new ol.Map({
        layers: layers,
        target: 'map',
        renderer:'canvas',
        controls: [mousePositionControl,control,zoomCtl]
        ,
        view: new ol.View({
            center: center,
            zoom: 14
        }),
//        interactions:[interaction]
    });
    map.addInteraction(interaction);
    var menu_overlay = new ol.Overlay({
        element: document.getElementById("contextmenu_container"),
        positioning: 'center-center'
    });
    menu_overlay.setMap(map);
    $(map.getViewport()).on("contextmenu", function (e) {
        e.preventDefault();
        var coordinate = map.getEventCoordinate(e);
        menu_overlay.setPosition(coordinate);
    });
    $(map.getViewport()).on("click", function (e) {
        e.preventDefault();
        menu_overlay.setPosition(undefined);
    });
    var draw;
    function addInteraction() {
        draw = new ol.interaction.Draw({
            source: source,
            type: 'Circle',
            freehand: true
        });
        map.addInteraction(draw);
        draw.on("drawend", function (e) {
            var center = e.feature.getGeometry().getCenter();
            var radius = e.feature.getGeometry().getRadius();
            var cvtPoint = ol.proj.transform(center, 'EPSG:3857', 'EPSG:4326');
            console.log(cvtPoint + ',' + radius);
            var d = radius / 1000;
            var lat = cvtPoint[1];
            var lng = cvtPoint[0];
            $.getJSON("geoanalyzer/findloc",
                    {
                        loc: lat + "," + lng,
                        r: d,
                        name: $('#name').val()
                    },
                    function (json) {
                        for (var i = 0; i < json.length; i++) {
                            var pt = json[i];
                            console.log(pt.loc + "," + pt.name);
                            var x = pt.loc.split(",")[0];
                            var y = pt.loc.split(",")[1];
                            var loc = [x, y];
                            addMarker(loc, pt.name, loc.id);
                        }
                    }
            )
        })
    }

    function removeInteraction() {
        map.removeInteraction(draw);
        map.removeInteraction(interaction);
    }
    //    addInteraction();
    function clearAll() {
        source.clear();
        map.getOverlays().clear();
    }


    function addMarker(loc, name, id) {
        var marker = new ol.Overlay({
            element: $('<div class="marker" id="' + id + '" title="' + name + '"></div>')[0]
        });
        marker.setMap(map);
        marker.setPosition(loc);
        map.addOverlay(marker);
    }

    map.on('click', function(event) {
        var coord = event.coordinate;
        var degrees = ol.proj.transform(coord, 'EPSG:3857', 'EPSG:4326')
        var hdms = ol.coordinate.toStringHDMS(degrees);
        var element = overlay.getElement();
        element.innerHTML = hdms;
        overlay.setPosition(coord);
        map.addOverlay(overlay);
    });
    function moveendFun(event){
        console.log("moveend");
    }
    map.on("moveend",moveendFun);

    var checkbox = document.querySelector('#visible');

    checkbox.addEventListener('change', function() {
        var checked = this.checked;
        if (checked !== osmLayer.getVisible()) {
            osmLayer.setVisible(checked);
        }
    });

    osmLayer.on('change:visible', function() {
        var visible = this.getVisible();
        if (visible !== checkbox.checked) {
            checkbox.checked = visible;
        }
    });
</script>
</body>
</html>