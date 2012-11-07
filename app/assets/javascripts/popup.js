$(function() {
	$("#contact_popup_container th a, #contact_popup_container .pagination a").live("click", function() {
		$.getScript(this.href);
		return false;
	});

	$("#contact_lists_search input").live("keyup", function() {
		$.get($("#contact_lists_search").attr("action"), $("#contact_lists_search").serialize(), null, "script");
		return false;
	});
});
