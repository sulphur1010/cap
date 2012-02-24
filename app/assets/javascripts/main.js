$(function() {
	$('textarea.js_editor').tinymce({ theme: 'advanced' });
	$('select.js_multiselect').multiSelect();
	$('input.js_datetime').datetimepicker({
		timeFormat: 'hh:mm:ss',
		dateFormat: 'yy-mm-dd'
	});

	$(".js_start_date").datetimepicker({
		timeFormat: 'hh:mm:ss',
		dateFormat: 'yy-mm-dd',
		onClose: function(dateText, inst) {
				var endDateTextBox = $('.js_end_date');
				if (endDateTextBox.val() != '') {
						var testStartDate = new Date(dateText);
						var testEndDate = new Date(endDateTextBox.val());
						if (testStartDate > testEndDate)
								endDateTextBox.val(dateText);
				}
				else {
						endDateTextBox.val(dateText);
				}
		},
		onSelect: function (selectedDateTime) {
			var start = $(this).datetimepicker('getDate');
			$(".js_end_date").datetimepicker('option', 'minDate', new Date(start.getTime()));
		}
	});

	$(".js_end_date").datetimepicker({
		timeFormat: 'hh:mm:ss',
		dateFormat: 'yy-mm-dd',
		onClose: function(dateText, inst) {
				var startDateTextBox = $('.js_start_date');
				if (startDateTextBox.val() != '') {
						var testStartDate = new Date(startDateTextBox.val());
						var testEndDate = new Date(dateText);
						if (testStartDate > testEndDate)
								startDateTextBox.val(dateText);
				}
				else {
						startDateTextBox.val(dateText);
				}
		},
		onSelect: function (selectedDateTime){
				var end = $(this).datetimepicker('getDate');
				$('.js_start_date').datetimepicker('option', 'maxDate', new Date(end.getTime()) );
		}
	});

	email = $("#js_email_address");
	if (email.length == 1) {
		email.inputLabel(email.attr('data-label'), { color: '#777' });
	}

	$(".formtastic fieldset legend span").click(function() {
		elements = $(this).parents("legend").siblings("ol");
		elements.slideToggle();
		if (elements.is(":visible")) {
			$(this).removeClass("collapsed");
		} else {
			$(this).addClass("collapsed");
		}
	});

	slideshow.init();
});

var slideshow = new function() {
	var elms =  null;
	var active = null;
	var hover = null;
	var timeout = null;
	var fadeLength = null;
	var timer = null;

	this.init = function() {
		slideshow.elms = $(".js_slideshow");
		slideshow.elms.mouseover(slideshow.mouseover);
		slideshow.elms.mouseout(slideshow.mouseout);
		slideshow.active = 0;
		slideshow.timeout = 9000;
		slideshow.fadeLength = 500;
		slideshow.hover = false;
		slideshow.timer = setTimeout(slideshow.fadeOut, slideshow.timeout);
	};

	this.fadeOut = function() {
		if (!slideshow.hover) {
			$(slideshow.elms[slideshow.active]).fadeOut(slideshow.fadeLength, slideshow.fadeIn);
		}
	};

	this.fadeIn = function() {
		slideshow.active += 1;
		if (slideshow.active >= slideshow.elms.length) {
			slideshow.active = 0;
		}
		$(slideshow.elms).hide();
		$(slideshow.elms[slideshow.active]).fadeIn(slideshow.fadeLength);
		clearTimeout(slideshow.timer);
		slideshow.timer = setTimeout(slideshow.fadeOut, slideshow.timeout);
	};

	this.mouseover = function() {
		slideshow.hover = true;
	};

	this.mouseout = function() {
		slideshow.hover = false;
		clearTimeout(slideshow.timer);
		slideshow.timer = setTimeout(slideshow.fadeOut, 2000);
	};
};

/**
 * jQuery Initial input value replacer
 * 
 * Sets input value attribute to a starting value  
 * @author Marco "DWJ" Solazzi - hello@dwightjack.com
 * @license  Dual licensed under the MIT (http://www.opensource.org/licenses/mit-license.php) and GPL (http://www.opensource.org/licenses/gpl-license.php) licenses.
 * @copyright Copyright (c) 2008 Marco Solazzi
 * @version 0.1
 * @requires jQuery 1.2.x
 */
(function (jQuery) {
	/**
	 * Setting input initialization
	 *  
	 * @param {String|Object|Bool} text Initial value of the field. Can be either a string, a jQuery reference (example: $("#element")), or boolean false (default) to search for related label
	 * @param {Object} [opts] An object containing options: 
	 * 							color (initial text color, default : "#666"), 
	 * 							e (event which triggers initial text clearing, default: "focus"), 
	 * 							force (execute this script even if input value is not empty, default: false)
	 * 							keep (if value of field is empty on blur, re-apply initial text, default: true)  
	 */
	jQuery.fn.inputLabel = function(text,opts) {
		o = jQuery.extend({ color: "#666", e:"focus", force : false, keep : true}, opts || {});
		var clearInput = function (e) {
			var target = jQuery(e.target);
			var value = jQuery.trim(target.val());
			if (e.type == e.data.obj.e && value == e.data.obj.innerText) {
				jQuery(target).css("color", "").val("");
				if (!e.data.obj.keep) {
					jQuery(target).unbind(e.data.obj.e+" blur",clearInput);
				}
			} else if (e.type == "blur" && value == "" && e.data.obj.keep) {
				jQuery(this).css("color", e.data.obj.color).val(e.data.obj.innerText);
			}
		};
		return this.each(function () {
					o.innerText = (text || false);
					if (!o.innerText) {
						var id = jQuery(this).attr("id");
						o.innerText = jQuery(this).parents("form").find("label[for=" + id + "]").hide().text();
					}
					else 
						if (typeof o.innerText != "string") {
							o.innerText = jQuery(o.innerText).text();
						}
			o.innerText = jQuery.trim(o.innerText);
			if (o.force || jQuery(this).val() == "") {
				jQuery(this).css("color", o.color).val(o.innerText);
			}
				jQuery(this).bind(o.e+" blur",{obj:o},clearInput);
			
		});
	};
})(jQuery);

