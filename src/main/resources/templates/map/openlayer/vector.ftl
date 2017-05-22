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

    .half-map{
        width: 100%;
        height: 80%;
    }

</style>

<body>
<div id="map" class="half-map"></div>
<div id="name"></div>
<script>
    var osmLayer=
            new ol.layer.Tile({
                source: new ol.source.OSM(),
                projection: 'EPSG:3857'
            });
    var high = [64,196,64,1];
    var mid = [108,152,64,1];
    var low = [152,108,64,1];
    var poor = [196,32,32,1];

    var incomeLevels = {
        'HIC': high, // high income
        'OEC': high, // high income OECD
        'NOC': high, // high income, non-OECD
        'UMC': mid, // upper middle income
        'MIC': mid, // middle income
        'LMC': mid, // lower middle income
        'LIC': low, // low income
        'LMY': low, // low and middle income
        'HPC': poor // heavily indebted poor country
    };

    var defaultStyle = new ol.style.Style({
        fill: new ol.style.Fill({
            color: [250,250,250,1]
        }),
        stroke: new ol.style.Stroke({
            color: [220,220,220,1],
            width: 1
        })
    });
    var styleCache = {};
    function styleFunction(feature, resolution) {
        var level = feature.get('incomeLevel');
        if (!level || !incomeLevels[level]) {
            return [defaultStyle];
        }
        if (!styleCache[level]) {
            styleCache[level] = new ol.style.Style({
                fill: new ol.style.Fill({
                    color: incomeLevels[level]
                }),
                stroke: defaultStyle.stroke
            });
        }
        return [styleCache[level]];
    }

    var countryStyle = new ol.style.Style({
        fill: new ol.style.Fill({
            color: [203, 0, 0, 1]
        }),
        stroke: new ol.style.Stroke({
            color: [177, 163, 148, 0.5],
            width: 2
        })
    });

    var timezoneStyle = new ol.style.Style({
        stroke: new ol.style.Stroke({
            color: [64, 200, 200, 0.5],
        }),
        text: new ol.style.Text({
            font: '20px Verdana',
            text: 'TZ',
            fill: new ol.style.Fill({
                color: [64, 64, 64, 0.75]
            })
        })
    });
    var countries = new ol.layer.Vector({
        source: new ol.source.Vector({
            url: 'https://openlayers.org/en/v4.1.1/examples/data/geojson/countries.geojson',
            format: new ol.format.GeoJSON()
        }),
        style:styleFunction
    });

    var timeZone = new ol.layer.Vector({
        source: new ol.source.Vector({
            url: 'https://openlayers.org/en/v4.1.1/examples/data/kml/timezones.kml',
            format: new ol.format.KML({
                extractStyles: false
            })
        }),
        style:timezoneStyle
    });


    var center = ol.proj.transform([0, 0], 'EPSG:4326', 'EPSG:3857');
    var view = new ol.View({
        center: center,
        zoom: 1,
    });
    var map = new ol.Map({
        target: 'map',
        layers: [countries],
        view: view
    });

    map.on("pointermove",onMouseMove);
    var highlightStyleCache = {};
    var featureOverlay = new ol.layer.Vector({
        source: new ol.source.Vector(),
        map: map,
        style: function(feature, resolution) {
            var text = resolution < 5000 ? feature.get('name') : '';
            if (!highlightStyleCache[text]) {
                highlightStyleCache[text] = new ol.style.Style({
                    stroke: new ol.style.Stroke({
                        color: '#f00',
                        width: 1
                    }),
                    fill: new ol.style.Fill({
                        color: 'rgba(255,0,0,0.1)'
                    }),
                    text: new ol.style.Text({
                        font: '12px Calibri,sans-serif',
                        text: text,
                        fill: new ol.style.Fill({
                            color: '#000'
                        }),
                        stroke: new ol.style.Stroke({
                            color: '#f00',
                            width: 3
                        })
                    })
                });
            }
            return highlightStyleCache[text];
        }
    });
    map.addLayer(featureOverlay)
    var highlight;
    function onMouseMove(browserEvent)
    {
        var coordinate = browserEvent.coordinate;
        var pixel=map.getPixelFromCoordinate(coordinate);
        var el = document.getElementById('name');
        el.innerHTML = '';
        map.forEachFeatureAtPixel(pixel,function(feature){
            el.innerHTML += feature.get('name') + '<br>';
            if (highlight) {
                featureOverlay.getSource().removeFeature(highlight);
            }
            if (feature) {
                featureOverlay.getSource().addFeature(feature);
            }
            highlight = feature;
        })
    }
</script>
</body>
</html>