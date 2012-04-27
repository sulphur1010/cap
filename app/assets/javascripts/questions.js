$(function() {
	$(document).delegate('.answer_button', 'click', function() {
		var qid = $(this).attr('data-id');
		$('.answer_popup').hide();
		$('.answer_popup[data-id="' + qid + '"]').show();
	});

	$(document).delegate('.answer_popup .answer_close', 'click', function() {
		$('.answer_popup').hide();
	});
});
