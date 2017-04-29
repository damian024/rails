// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require trix
//= require underscore
//= require gmaps/google
//= require jquery3
//= require jquery_ujs

/*var generateMap = function (){
    if($('#map').length == 1){
         handler = Gmaps.build('Google');
         map = handler.buildMap({
            provider: {
                disableDefaultUI: true
                // pass in other Google Maps API options here
            },
            internal: {
                id: 'map'
            }
        });
        console.log(handler);
        map.addListener('click', function(event){
            console.log("click");
        });
    }
};

$(document).ready(function (){
    generateMap();
}); */
var marker;
function initMap() {
    var onlyView = typeof $("#map").attr("lat") !==  typeof undefined && typeof $("#map").attr("lng") !== typeof undefined;
    var uluru = {lat: -25.363, lng: 131.044};
    var zoomSize = (onlyView) ? 13: 9;
    map = new google.maps.Map(document.getElementById('map'), {
        zoom: zoomSize,
        center: uluru
    });
    var lng = parseFloat($("#map").attr("lng"));
    var lat = parseFloat($("#map").attr("lat"));
    if(!isNaN(lng) && !isNaN(lat) ) {
        placeMarker({lat: lat, lng: lng})
        map
    }
    else if (!onlyView){
        google.maps.event.addListener(map, 'click', function (event) {
            placeMarker(event.latLng);
        });
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                var pos = {
                    lat: position.coords.latitude,
                    lng: position.coords.longitude
                };
                map.setCenter(pos);
            });
        }
    }
}
function SetFirstPiont(){
    var lng = parseFloat($("#flat_longitude").val());
    var lat = parseFloat($("#flat_latitude").val());
    if(!isNaN(lng) && !isNaN(lat) ) {
        placeMarker({lat: lat, lng: lng})
    }
}
function placeMarker(location) {
    if(marker !== undefined) {
        console.log(marker);
        marker.setMap(null)
    }
    marker = new google.maps.Marker({
        position: location,
        map: map
    });
    map.panTo(marker.getPosition());
    $("#flat_longitude").val(location.lng);
    $("#flat_latitude").val(location.lat);
}






