var Notice = new function() {

	this.show_notice = function(message) {
		$('#notice').html(message);
		$('#notice').slideDown('slow').delay(3000).slideUp('slow');
	};
};
