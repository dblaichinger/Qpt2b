$(document).ready(function() { 
	// Scrolling
	// Example: <span class="toScroll" rel="target.id">Some text</span>
	$(".toScroll").click(function() {
		$.scrollTo("#" + $(this).attr("rel"), 2000);
	});


	// Set trashcan_id to order form input
	$(".trashcanID").click(function() {
		$("#user_orders_attributes_0_trashcan_id").val( 2 ); //$(this).attr("id")
		console.log("Dong");
	});


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
   google.maps.event.addListener(Gmaps4Rails.map, 'click', function(object){ marker = new google.maps.Marker({position: object.latLng, map: Gmaps4Rails.map});});

   //latitude can be retrieved with: object.latLng.lat(), longitude with: object.latLng.lng()
}
