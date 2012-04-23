class AddFeatureOnHomepageToContentFragments < ActiveRecord::Migration
  def change
		add_column :content_fragments, :feature_on_homepage, :boolean
  end
end
