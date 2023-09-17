//= require active_admin/base
//= require chartkick
//= require Chart.bundle

$(document).ready(function () {
  if ($("form.tranxaction").length) {
    $("#tranxaction_tranxactable_type").change(function () {
      if ($("#tranxaction_tranxactable_type").val().length) {
        $("#tranxaction_tranxactable_id_input").show();
      } else {
        $("#tranxaction_tranxactable_id_input").hide();
      }
    });
  }
});
