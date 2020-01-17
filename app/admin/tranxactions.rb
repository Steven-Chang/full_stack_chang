# frozen_string_literal: true

# params['commit'] exists when filters are selected
ActiveAdmin.register Tranxaction do
  # === INDEX ===
  config.sort_order = 'date_desc'

  index do
    id_column
    column :date
    column :description
    column :amount do |tranxaction|
      number_to_currency(tranxaction.amount)
    end
    column :tax
    column :tax_category do |tranxaction|
      tranxaction&.tax_category&.description
    end
    column 'Tranxactable' do |tranxaction|
      next if tranxaction.tranxactable.blank?

      link_description = "#{tranxaction.tranxactable.class}: "
      if tranxaction.tranxactable.class == TenancyAgreement
        link_description += tranxaction.tranxactable.user.username
      elsif tranxaction.tranxactable.class == Client
        link_description += tranxaction.tranxactable.name
      elsif tranxaction.tranxactable.class == Property
        link_description += tranxaction.tranxactable.address
      end
      url = "/admin/#{tranxaction.tranxactable.class.to_s.underscore.pluralize}/#{tranxaction.tranxactable.id}"
      link_to link_description, url
    end
    column :creditor
    column :attachments do |tranxaction|
      next if tranxaction.attachments.blank?

      table_for tranxaction.attachments.order('created_at DESC') do
        column 'Attachments' do |attachment|
          url = if attachment.url.present?
            attachment.url
          elsif attachment.cloudinary_public_id.present?
            cloudinary_url(attachment.cloudinary_public_id, resource_type: :raw)
          end
          link_to 'url', url, target: '_blank', rel: 'noopener'
        end
      end
    end
    actions
  end

  filter :amount
  filter :creditor, collection: lambda {
    Creditor.all.map { |creditor| [creditor.name, creditor.id] }
  }
  filter :creditor_id_present, as: :boolean
  filter :date
  filter :description
  filter :tax
  filter :tax_category, collection: lambda {
    TaxCategory.all.map { |tax_category| [tax_category.description, tax_category.id] }
  }
  filter :tax_category_id_present, as: :boolean
  filter :tranxactable_type_present, as: :boolean
  filter :tranxactable_type, collection: %w[Client Property TenancyAgreement]
  filter :tranxactable_id, as: :select,
                           collection: proc {
                             Client.all.map { |client| [client.name, client.id] } +
                               Property.all.map { |property| [property.address, property.id] } +
                               TenancyAgreement.all.map do |tenancy_agreement|
                                 [tenancy_agreement.reference, tenancy_agreement.id]
                               end
                           }

  # === SHOW ===
  show do
    attributes_table do
      row :id
      row :date
      row :description
      row :amount do |tranxaction|
        number_to_currency(tranxaction.amount)
      end
      row :tax
      row :tax_category do |tranxaction|
        tranxaction&.tax_category&.description
      end
      row :tranxactable do |tranxaction|
        next if tranxaction.tranxactable.blank?

        link_description = "#{tranxaction.tranxactable.class}: "
        if tranxaction.tranxactable.class == TenancyAgreement
          link_description += tranxaction.tranxactable.user.username
        elsif tranxaction.tranxactable.class == Client
          link_description += tranxaction.tranxactable.name
        elsif tranxaction.tranxactable.class == Property
          link_description += tranxaction.tranxactable.address
        end
        url = "/admin/#{tranxaction.tranxactable.class.to_s.underscore.pluralize}/#{tranxaction.tranxactable.id}"
        link_to link_description, url
      end
      row :creditor
      table_for tranxaction.attachments.order('created_at DESC') do
        column 'Attachments' do |attachment|
          if attachment.url.present?
            link_to attachment.url, attachment.url, target: '_blank', rel: 'noopener'
          elsif attachment.cloudinary_public_id.present?
            link_to 'url', cloudinary_url(attachment.cloudinary_public_id, resource_type: :raw), target: '_blank', rel: 'noopener'
          end
        end
      end
    end
  end

  # === FORM ===
  form do |f|
    f.object.date ||= Date.current
    f.inputs do
      f.input :date, required: true
      f.input :description, required: true
      f.input :amount, required: true
      f.input :tax
      f.input :tax_category, member_label: :description
      f.input :tranxactable_type, collection: %w[Client Property TenancyAgreement]
      f.input :tranxactable_id, as: :select, collection: Client.all.map { |client| [client.name, client.id] } + Property.all.map { |property| [property.address, property.id] } + TenancyAgreement.all.map { |tenancy_agreement| [tenancy_agreement.reference, tenancy_agreement.id] }, wrapper_html: { style: 'display: none;' }
      f.input :creditor, member_label: :name, collection: Creditor.order('LOWER(name)')
      f.has_many :attachments,
                 heading: 'Attachments',
                 new_record: 'Manually create an attachment',
                 allow_destroy: true do |a|
        a.input :cloudinary_public_id
        a.input :url
        a.object.file_type = a.object.persisted? ? a.object.file_type : 'video'
        a.input :file_type, as: :select,
                            collection: Attachment.file_types.keys,
                            include_blank: false
      end
      li '<label>Cloudinary upload</label><button id="upload_widget" class="cloudinary-button">Upload image</button>
          <!-- Cloudinary - Upload -->
          <script src="https://widget.cloudinary.com/v2.0/global/all.js" type="text/javascript"></script>
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
  permit_params :amount,
                :creditor_id,
                :date,
                :description,
                :tax,
                :tax_category_id,
                :tranxactable_type,
                :tranxactable_id,
                attachments_attributes: %i[id cloudinary_public_id file_type url _destroy]
end
