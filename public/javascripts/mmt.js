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

var marker = null;
function gmaps4rails_callback() {
   Gmaps4Rails.clear_markers();
   if (marker != null) { marker.setMap(null); }
   google.maps.event.addListener(Gmaps4Rails.map, 'click', function(object){ marker = new google.maps.Marker({position: object.latLng, map: Gmaps4Rails.map});});

   //latitude can be retrieved with: object.latLng.lat(), longitude with: object.latLng.lng()
}