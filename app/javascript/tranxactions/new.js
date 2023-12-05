export const TRANSACTIONS_NEW = {
  init: async () => {
    let url = $("#tranxaction_attachments").attr("data-direct-upload-url");
    let dropZone = new Dropzone("#transactions-attachments-dropzone", {
      maxFileSize: 5,
      addRemoveLinks: true,
      autoQueue: false,
      url,
    });
    dropZone.on("addedfile", (file) => {
      setTimeout(() => {
        if (file.accepted) {
          let directUpload = new window.DirectUpload(file, url);
          directUpload.create((error, attributes) => {
            if (error) {
              // document.showAlertDanger(error);
              // dropZone.removeFile(file);
            } else {
              // Create input with signed id when successful
              const hiddenField = document.createElement("input");
              hiddenField.setAttribute("type", "hidden");
              hiddenField.setAttribute("value", attributes.signed_id);
              hiddenField.setAttribute("id", file.upload.uuid);
              hiddenField.name = "tranxaction[attachments][]";
              $("form#new_tranxaction").append(hiddenField);
            }
          });
        }
      }, 500);
    });

    dropZone.on("removedfile", (file) => {
      $(`#${file.upload.uuid}`).remove();
    });
  },
};
