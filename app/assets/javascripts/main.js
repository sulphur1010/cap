$(function() {
  $('textarea.editor').tinymce({ theme: 'advanced' });

  $(".formtastic fieldset legend span").click(function() {
    elements = $(this).parents("legend").siblings("ol");
    elements.toggle();
    if (elements.is(":visible")) {
      $(this).removeClass("collapsed");
    } else {
      $(this).addClass("collapsed");
    }
  });
});
