export const TRANSACTIONS_NEW = {
  init: async () => {
    let dropZone = new Dropzone("#transactions-attachments-dropzone", {
      maxFileSize: 5,
      addRemoveLinks: true,
      autoQueue: false,
      url: 'doesnotmatter'
    });
  }
};
