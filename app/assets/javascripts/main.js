$(function() {
  $('textarea.js_editor').tinymce({ theme: 'advanced' });
  $('select.js_multiselect').multiSelect();

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
