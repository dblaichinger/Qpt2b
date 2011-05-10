// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/*
  MMT.JS
  QPT2b MMT09 - made by Andre Schweighoder, Daniel Blaichinger, Francois Weber

  _DESCRIPTION:
    - This file includes most of the own javascript code of the site
*/

$(document).ready(function() { 

	// Scrolling
	// Example: <span class="toScroll" rel="target.id">Some text</span>
	$(".toScroll").click(function() {
		$.scrollTo("#" + $(this).attr("rel"), 2000);
	});

	// Get current geo position
  	getPosition();

});

// --------------------------------------------------
// GeoTool Helper Class
var GeoTool = function() {
  
    that = this;
    this.address = "";
    that.lat = 0.0;
    that.lng = 0.0;

    var RADIUS = 50;

    this.reverseGeoCode = function(lat, lng) {
       
        var geocoder = new google.maps.Geocoder();
        var latlng = new google.maps.LatLng(lat, lng);

        geocoder.geocode({'latLng': latlng}, function(results, status) {
          if (status == google.maps.GeocoderStatus.OK) {
            if (results[1]) {
              that.address = results[1].formatted_address;
              console.log("Addr1: " + that.address);
            }            
          }
        });

        return that.address;
    },

    this.addMarker = function(lat, lng) {   
      that.lat = lat;
      that.lng = lng;   
      var marker = new google.maps.Marker({
              map: Gmaps4Rails.map,
              position: new google.maps.LatLng(that.lat, that.lng)
      });
      return marker;
    },

    this.addCircle = function(lat, lng) {
       
      var marker = that.addMarker(lat, lng);
      var circle = new google.maps.Circle({
              map: Gmaps4Rails.map,
              radius: RADIUS,
              fillColor: '#AA0000'
      });
      circle.bindTo('center', marker, 'position');   
    }

}

// --------------------------------------------------
// Order: Set Trashcan id in order form
function setTrashcanId(val) {
	$("#user_orders_attributes_0_trashcan_id").val( val );
	$.scrollTo("#editor", 2000);
}

// --------------------------------------------------
// Vote function for trashcan demands
function vote( id ) {
  // user already voted within the last 24 hours
  if($.cookie('demand') == "true") {
    $('.markerInfo').html('Du kannst nur alle 24 Stunden abstimmen');
  }
  // user is allowed to vote
  else {
    // send vote via ajax
    $.ajax({
      type: 'POST', 
      url: '/demands/vote/',
      data: 'id='+id
    });
    // remember the vote 
    $.cookie('demand', "true", { expires: 1 });
    $('.markerInfo').html('Erfolgreich gevotet');
  }
  $('.voteButton').hide();
}

// --------------------------------------------------
// GoogleMap Callback
function gmaps4rails_callback() {
   
   var marker = null;
   
   Gmaps4Rails.clear_markers();
   if (marker != null) { marker.setMap(null); }

   //google.maps.event.addListener(google.maps.Circle, 'click',  function(){ console.log("clicked radius"); });

   //google.maps.event.addListener(object, “click”, function() { console.log("clicked radius"); });

   google.maps.event.addListener(Gmaps4Rails.map, 'click', function(object){

     $("#dialog").dialog({
    	bgiframe: true,
    	autoOpen: false,
    	height: 300,
    	modal: true,
    	buttons: {
    		OK: function() {

            var geoTool = new GeoTool();
            //TODO: var address = geoTool.reverseGeoCode(object.latLng.lat(), object.latLng.lng());

            // -----------------------------------------
            // Add CIRCLE to Map
            var circle = geoTool.addCircle(object.latLng.lat(), object.latLng.lng());

            // -----------------------------------------
            // Get Address of Long Lat
            var geocoder = new google.maps.Geocoder();
            var latlng = new google.maps.LatLng(object.latLng.lat(), object.latLng.lng());
            geocoder.geocode({'latLng': latlng}, function(results, status) {
              if (status == google.maps.GeocoderStatus.OK) {
                if (results[1]) {

                  // Save in Database
                  $.ajax({
                    type: 'POST',
                    url: '/demands/',
                    data: 'address=' + results[0].formatted_address
                  });
                }
              }
            });

          $(this).dialog('close');
    		},
    		Abbrechen: function() {
    			$(this).dialog('close');
    		}
    	}
    });
    openDialog();
   });
}

function openDialog() {
  $('#dialog').dialog('open');
}

// --------------------------------------------------
// Get current position of user
function getPosition(){
  
  var browserSupportFlag =  new Boolean();
  var infowindow = new google.maps.InfoWindow();
  var initialLocation;

  if(navigator.geolocation) {

        var browserSupportFlag = true;

        navigator.geolocation.getCurrentPosition(function(position) {

          initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
          
          Gmaps4Rails.map.setCenter(initialLocation);
          Gmaps4Rails.map.setZoom(15);

          var contentString = "Location found - you are here !";
          
          infowindow.setContent(contentString);
          infowindow.setPosition(initialLocation);
          infowindow.open(Gmaps4Rails.map);

          $.scrollTo("#map", 1000);
        }, function() {
          handleNoGeolocation(browserSupportFlag);
        });
   } else if (google.gears) {
      // Try Google Gears Geolocation
      browserSupportFlag = true;
      var geo = google.gears.factory.create('beta.geolocation');
      geo.getCurrentPosition(function(position) {
        initialLocation = new google.maps.LatLng(position.latitude,position.longitude);
        contentString = "Location found using Google Gears";
        map.setCenter(initialLocation);
        infowindow.setContent(contentString);
        infowindow.setPosition(initialLocation);
        infowindow.open(Gmaps4Rails.map);
      }, function() {
        handleNoGeolocation(browserSupportFlag);
      });
  } else {
    // Browser doesn't support Geolocation
    browserSupportFlag = false;
    handleNoGeolocation(browserSupportFlag);
  }

  function handleNoGeolocation(errorFlag) {
    if (errorFlag == true) {
      contentString = "Error: The Geolocation service failed.";
    } else {
      contentString = "Error: Your browser doesn't support geolocation.";
    }
    infowindow.setContent(contentString);
    infowindow.open(map);
  }
}
