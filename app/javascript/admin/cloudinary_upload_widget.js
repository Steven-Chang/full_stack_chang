$(document).ready(function() {
  var jquerySelectors = ["form.blog_post", "form.tool", "form.tranxaction"];
  $.each(jquerySelectors, function(key, value) { 
    if($(value).length) {
      // Cloudinary - Upload
      var myWidget = cloudinary.createUploadWidget({
        cloudName: "hpxlnqput",
        uploadPreset: "jumnv4bk"}, (error, result) => {
        if (!error && result && result.event === "success") {
          console.log("Done! Here is the image info: ", result.info);
          $(".has_many_add")[0].click();
          $(".has_many_fields").last().find("input").first().val(result.info.public_id);
          if(value == "form.tranxaction" || value == "form.blog_post") {
            $(".has_many_fields").last().find("select").first().val(result.info.resource_type);
          };
        }
      })
      document.getElementById("upload_widget").addEventListener("click", function(evt){
        myWidget.open();
        evt.preventDefault();
      }, false);
      return false;
    };
  });
});
