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
	//if(typeof position === 'undefined'){

	currentURL = window.location.toString();


	if(currentURL.search("demands")==-1 && currentURL.search("info")==-1){ 
		if(currentURL.search("latitude")==-1 && currentURL.search("latitude")==-1){
			getPosition();
		}
		else {
			location.href='#map';
		}
	}

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
          $('#address_field').reversegeocode({
                    lat: object.latLng.lat(),
                    lng: object.latLng.lng()
                });
          var a = $('#address_field').html();
          alert($('#address_field').html(););
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

		if (navigator.geolocation) {
	 		navigator.geolocation.getCurrentPosition(success, error);
		} else {
	  		alert("Not Supported!");
		}

	function success(position) {
  		//console.log(position.coords.latitude);
  		//console.log(position.coords.longitude);
  		sendPosition(position.coords.longitude, position.coords.latitude);
	}

	function error(msg) {
 	 console.log(typeof msg == 'string' ? msg : "error");
	}

}


//Send current position to get marker on the map
function sendPosition(longitude, latitude) {
	$(location).attr('href','/pages/home?latitude='+latitude+"&longitude="+longitude);
}
