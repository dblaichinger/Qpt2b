/*
  application.JS
  QPT2b MMT09 - made by Andre Schweighoder, Daniel Blaifinger, Francmois Weber

  _DESCRIPTION:
    - This file includes most of the own javascript code of the site
*/

$(document).ready(function() {

  // Hide XML output
  $("#xmlOutput").hide();

	// Scrolling
	// Example: <span class="toScroll" rel="target.id">Some text</span>
	$(".toScroll").click(function() {
		$.scrollTo("#" + $(this).attr("rel"), 2000);
	});

	// Get current geo position
  	getPosition();

   if($.cookie('demand') == "true") {
      $('.vote_button').hide();
    }


    $('.top_vote_form').submit(function() {voteClicked($(this).children('.vote_button').attr('id'), false);});

    $('#editorSaveButton').click(function() { 
      $('#isDesignSet').show();
      $('#isDesignSetImage').attr("src", "/images/icon_design_uebernommen.png");
      $('#isDesignSetText').html("Design ausgew&auml;hlt");
      $.scrollTo("#step5", 2000);
    });

 
    $('#slides').cycle({
      fx: 'fade'
     });

});

// Vote-Button was clicked (within maps or top demands)
function voteClicked($this, $fromMap) {
    // don't let user click again
    $('.vote_button').hide();
    
    //do not increase the counters html value, if not allowed to vote
    if($.cookie('demand') != 'true') {
      // increase counter at users view
      var sel = '#counter_' + $this;
      var countString = "" + (parseInt($(sel).html()) + 1);
      $(sel).html(countString);
      $('.top_vote_info').html('Danke für Deine Stimme!');
    }

    // if vote was sent from map, call AJAX vote
    // otherwise vote was already executed by rails remote form
    if($fromMap) {vote($this);};
}

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
              //console.log("Addr1: " + that.address);
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
    },


    this.GeoCode = function(address) {
       


   return false;
}
}

// --------------------------------------------------
// Order: Set Trashcan id in order form
function setTrashcanId(val) {
	$("#user_orders_attributes_0_trashcan_id").val( val );
	$.scrollTo("#step4", 2000);
  $("#isTrashcanSet").show();
  $("#isTrashcanSetText").html("Mülleimer ausgew&auml;hlt");
  $('#isTrashcanSetImage').attr("src", "/images/icon_muelleimer_uebernommen.png");
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
      data: 'id= '+ id
    });
    // remember the vote 
    $.cookie('demand', "true", { expires: 1 });
    $('.markerInfo').html(' Erfolgreich abgestimmt!');
  }
  $('.vote_button').attr('disabled', 'disabled');
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
            // var address = geoTool.reverseGeoCode(object.latLng.lat(), object.latLng.lng());

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

          var contentString = "Du befindest dich gerade hier!";
          
          infowindow.setContent(contentString);
          infowindow.setPosition(initialLocation);
          infowindow.open(Gmaps4Rails.map);

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

 function gmaps4rails_infobox(boxText) {
  return {
     content: boxText
    ,disableAutoPan: false
    ,maxWidth: 0
    ,pixelOffset: new google.maps.Size(-140, 0)
    ,zIndex: null
    ,boxStyle: { 
      background: "url('http://google-maps-utility-library-v3.googlecode.com/svn/tags/infobox/1.1.5/examples/tipbox.gif') no-repeat"
      ,opacity: 0.75
      ,width: "280px"
       }
    ,closeBoxMargin: "10px 2px 2px 2px"
    ,closeBoxURL: "http://www.google.com/intl/en_us/mapfiles/close.gif"
    ,infoBoxClearance: new google.maps.Size(1, 1)
    ,isHidden: false
    ,pane: "floatPane"
    ,enableEventPropagation: false
 }};


// -----------------------------------------------
// Search street on the map

  function searchForStreet(address){

    var geotool = new GeoTool();
    var geocoder = new google.maps.Geocoder();
    
    geocoder.geocode({'address': address}, function(results, status) {
    
    if (status == google.maps.GeocoderStatus.OK) {
               
        if (results[0]) {
             Gmaps4Rails.map.setCenter(results[0].geometry.location);
             Gmaps4Rails.map.setZoom(15);
           
             var marker = new google.maps.Marker({
                  map: Gmaps4Rails.map,
                  position: results[0].geometry.location
             });

            }
          }
          else {
                if(!address){
                  address = "Adresse";
                }

                alert(address + " konnte nicht gefunden werden");    
          }        
        });
 
    return false;
  }
 
// --------------------------------
// Gallery
