$(document).ready(function() { 
	// Scrolling
	// Example: <span class="toScroll" rel="target.id">Some text</span>
	$(".toScroll").click(function() {
		$.scrollTo("#" + $(this).attr("rel"), 2000);
	});


	// Set trashcan_id to order form input
	$(".toForm").click(function() {
		$("#user_orders_attributes_0_trashcan_id").val( $(this).attr("id") );
	});

});