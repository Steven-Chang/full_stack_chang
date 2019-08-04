# frozen_string_literal: true

# params['commit'] exists when filters are selected
ActiveAdmin.register BlogPost do
  # === INDEX ===
  index do
    column :date_added
    column :title
    column :description
    column :private
    actions
  end

  filter :date_added
  filter :private

  # === SHOW ===
  show do
    attributes_table do
      row :id
      row :title
      row :date_added
      row :description
      row :private
      row 'Images' do |blog_post|
        html = ''
        blog_post.attachments.where(file_type: 0).each do |attachment|
          html += "<img src=#{attachment.url}>"
        end
        html.html_safe
      end
    end
  end

  # === FORM ===
  form(html: { autocomplete: :off }) do |f|
    f.object.date_added ||= DateTime.current
    f.inputs do
      f.input :title
      f.input :date_added
      f.input :description
      li '<label>Cloudinary upload</label><button id="upload_widget" class="cloudinary-button">Upload image</button>
          <!-- Cloudinary - Upload -->
          <script src="https://widget.cloudinary.com/v2.0/global/all.js" type="text/javascript"></script>
          <script type="text/javascript">  
            var myWidget = cloudinary.createUploadWidget({
              cloudName: "hpxlnqput", 
              uploadPreset: "jumnv4bk"}, (error, result) => { 
              if (!error && result && result.event === "success") { 
                console.log("Done! Here is the image info: ", result.info); 
              }
            })
            document.getElementById("upload_widget").addEventListener("click", function(evt){
              myWidget.open();
              evt.preventDefault();
            }, false);
          </script>'.html_safe
      f.input :private
    end
    f.actions
  end

  # === PERMIT PARAMS ===
  permit_params :date_added,
                :description,
                :private,
                :title,
                attachments_attributes: %i[id cloudinary_public_id]
end
