$(document).ready(function() {
  if($("#edit_tool").length || $("#new_tool").length) {
    // Cloudinary - Upload
    var myWidget = cloudinary.createUploadWidget({
      cloudName: "hpxlnqput",
      uploadPreset: "jumnv4bk"}, (error, result) => {
      if (!error && result && result.event === "success") {
        console.log("Done! Here is the image info: ", result.info);
        $(".has_many_add").first().click();
        $(".has_many_fields").last().find("input").first().val(result.info.public_id);
      }
    })
    document.getElementById("upload_widget").addEventListener("click", function(evt){
      myWidget.open();
      evt.preventDefault();
    }, false);
  };
});
