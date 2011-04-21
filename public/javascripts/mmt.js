$(document).ready(function() { 
	// Scrolling
	// Example: <span class="toScroll" rel="target.id">Some text</span>
	$(".toScroll").click(function() {
		$.scrollTo("#" + $(this).attr("rel"), 2000);
	});


	// Set trashcan_id to order form input
	$(".trashcanID").click(function() {
		$("#user_orders_attributes_0_trashcan_id").val( 2 ); //$(this).attr("id")
	});

	//Get current position
  	getPosition();

});


function setTrashcanId(val) {
	$("#user_orders_attributes_0_trashcan_id").val( val );
	$.scrollTo("#editor", 2000);
}

// vote function for trashcan demands
function vote( id ) {
  // user already voted within the last 24 hours
  if($.cookie('demand') == "true") {
    $('.markerInfo').html('Du kannst nur alle 24 Stunden abstimmen');
  }
  // user is allowed to vote
  else {
    // send vote via ajax
    $.ajax({
      type: 'PUT', 
      url: '/demands/'+id
    });
    // remember the vote 
    $.cookie('demand', "true", { expires: 1 });
    $('.markerInfo').html('Erfolgreich gevotet');
  }
  $('.voteButton').hide();
}

var marker = null;
function gmaps4rails_callback() {
   Gmaps4Rails.clear_markers();
   if (marker != null) { marker.setMap(null); }
   google.maps.event.addListener(Gmaps4Rails.map, 'click', function(object){
     $("#dialog").dialog({
    	bgiframe: true,
    	autoOpen: false,
    	height: 300,
    	modal: true,
    	buttons: {
    		OK: function() {
          //marker = new google.maps.Marker({position: object.latLng, map: Gmaps4Rails.map});
          var g = $('#address_field').reversegeocode({
                    lat: object.latLng.lat(),
                    lng: object.latLng.lng()
                });

          var a = $('#address_field').html();
          console.log(g);
          //alert($('#address_field').html(););
          /*$.getJSON("http://maps.google.com/maps/api/geocode/json?latlng="+object.latLng.lat().toString()+","+object.latLng.lng().toString()+"&sensor=false", function(data) {
    alert("hey");
  });*/

          /*$.ajax({
            type: 'POST',
            url: '/demands/',
            data: 'longitude='+object.latLng.lng()+'&latitude='+object.latLng.lat()
          });*/
    		  $(this).dialog('close');
          //location.reload();
    		},
    		Abbrechen: function() {
    			$(this).dialog('close');
          confirmation = false;
    		}
    	}
    });
    openDialog();
   });
   //latitude can be retrieved with: object.latLng.lat(), longitude with: object.latLng.lng()
}

function openDialog() {
  $('#dialog').dialog('open');
}

//Get current position of user
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
