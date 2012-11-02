class EncyclicalChapter < ActiveRecord::Base
	belongs_to :encyclical
	has_many :encyclical_references

	searchable :include => [:encyclical] do
		integer :chapter_num
		text :chapter_body, :stored => true
		integer :encyclical_id
		string :author_ids, :multiple => true do self.encyclical.authors.collect { |c| c.id } end
		string :title do self.encyclical.title end
		date :published_at do self.encyclical.published_at end
	end

end
