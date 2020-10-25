# frozen_string_literal: true

# params['commit'] exists when filters are selected
ActiveAdmin.register BlogPost do
  # === CONFIG ===
  config.batch_actions = false
  config.sort_order = 'date_added_desc'

  # === INDEX ===
  index as: :blog, download_links: false do
    title do |blog_post|
      span blog_post.title, class: 'title'
    end
    body do |blog_post|
      div do
        div blog_post.date_added.strftime('%d %B %Y'), class: 'date_added'
        div(style: 'white-space: pre-wrap;') do
          blog_post.description
        end
        blog_post.attachments.where(file_type: 0).limit(9).order('RANDOM()').each do |attachment|
          next if attachment.cloudinary_public_id.blank?

          div(style: 'border: 1px solid lightgray; display: inline-block; height: 150px;') do
            cl_image_tag(attachment.cloudinary_public_id, height: 240, fetch_format: :auto, style: 'width: inherit; height: 100%;')
          end
        end
      end
    end
    # column :private
  end

  filter :date_added
  filter :description
  filter :private
  filter :title

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
          if attachment.url.present?
            html += "<img src=#{attachment.url}>"
          elsif attachment.cloudinary_public_id.present?
            html += cl_image_tag(attachment.cloudinary_public_id, fetch_format: :auto, height: 360, style: 'width: inherit;')
          end
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
      f.input :date_added, start_year: 1985
      f.input :description
      f.input :private
      f.has_many :attachments,
                 heading: 'Attachments',
                 new_record: 'Manually create an attachment',
                 allow_destroy: true do |a|
        a.input :cloudinary_public_id, hint: a.object.file_type == 'image' && a.object.cloudinary_public_id.present? ? cl_image_tag(a.object.cloudinary_public_id, height: 240, fetch_format: :auto, style: 'width: inherit;') : nil
        a.input :url
        a.object.file_type = a.object.persisted? ? a.object.file_type : 'video'
        a.input :file_type, as: :select,
                            collection: Attachment.file_types.keys,
                            include_blank: false
      end
      li '<label>Cloudinary upload</label><button id="upload_widget" class="cloudinary-button">Upload image</button>
          <!-- Cloudinary - Upload -->
          <script type="text/javascript">
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
          </script>'.html_safe
    end
    f.actions
  end

  # === PERMIT PARAMS ===
  permit_params :date_added,
                :description,
                :private,
                :title,
                attachments_attributes: %i[id cloudinary_public_id file_type url _destroy]
end
