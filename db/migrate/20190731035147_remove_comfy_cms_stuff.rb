class RemoveComfyCmsStuff < ActiveRecord::Migration[5.2]
  def change
  	drop_table :comfy_cms_categories
		drop_table :comfy_cms_categorizations
		drop_table :comfy_cms_files
		drop_table :comfy_cms_fragments
		drop_table :comfy_cms_layouts
		drop_table :comfy_cms_pages
		drop_table :comfy_cms_revisions
		drop_table :comfy_cms_sites
		drop_table :comfy_cms_snippets
		drop_table :comfy_cms_translations
  end
end
