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

function vote( id ) {
  $.ajax({
    type: 'PUT', 
    url: '/demands/'+id
  });
}
