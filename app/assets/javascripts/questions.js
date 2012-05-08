$(function() {
	$(document).delegate('.answer_button', 'click', function() {
		var qid = $(this).attr('data-id');
		$('.answer_popup').hide();
		var answer = $('.answer_popup[data-id="' + qid + '"]')
		var pos = $(this).position();
		answer.attr('style', 'top:' + pos.top + 'px');
		answer.show();
		
	});

	$(document).delegate('.answer_popup .answer_close', 'click', function() {
		$('.answer_popup').hide();
	});
});
