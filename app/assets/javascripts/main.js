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

  $(".formtastic fieldset legend span").click(function() {
    elements = $(this).parents("legend").siblings("ol");
    elements.slideToggle();
    if (elements.is(":visible")) {
      $(this).removeClass("collapsed");
    } else {
      $(this).addClass("collapsed");
    }
  });
});
