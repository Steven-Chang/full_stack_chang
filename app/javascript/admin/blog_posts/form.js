$(document).ready(function() {
  if($("#edit_blog_post").length || $("#new_blog_post").length) {
    // Cloudinary - Upload
    var myWidget = cloudinary.createUploadWidget({
      cloudName: "hpxlnqput",
      uploadPreset: "jumnv4bk"}, (error, result) => {
      if (!error && result && result.event === "success") {
        console.log("Done! Here is the image info: ", result.info);
        $(".has_many_add").first().click();
        $(".has_many_fields").last().find("input").first().val(result.info.public_id);
        $(".has_many_fields").last().find("select").first().val(result.info.resource_type);
      }
    })
    document.getElementById("upload_widget").addEventListener("click", function(evt){
      myWidget.open();
      evt.preventDefault();
    }, false);
  };
});
