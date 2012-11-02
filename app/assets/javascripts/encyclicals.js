// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
	$(".encyclical_chapter_link.encyclical_with_reference").click(function() {
		var t = $(this);
		var chapter = t.attr('data-chapter');
		var container = $("#chapter_" + chapter + "_reference_container");
		if (container.html() == "") {
			container.load("/encyclicals/" + t.attr('data-id') + "/chapter/" + chapter + "/references", {}, function() {
				$(this).show();
			});
		} else {
			container.toggle();
		}
	});
});
