class ContentFragment < ActiveRecord::Base

	attr_accessor :delete_thumbnail, :delete_image, :delete_homepage_image

	searchable :include => [ :users ] do
		text :title, :stored => true
		text :body, :stored => true
		string :title
		string :author_ids, :multiple => true do self.authors.collect { |c| c.id } end
		string :type
		string :encyclical_references, :stored => true, :multiple => true do parse_encyclical_references end
		date :published_at
		string :reference_name do reference_name end
	end

	has_and_belongs_to_many :users
	has_and_belongs_to_many :contemporary_issues
	has_and_belongs_to_many :person_types

	has_attached_file :thumbnail, :styles => { :normal => "200x100" }
	has_attached_file :image, :styles => { :normal => "720x405" }
	has_attached_file :homepage_image

	has_many :encyclical_references
	has_many :encyclicals, :through => :encyclical_references
	has_many :questions
	#has_many :audio_contents
	#accepts_nested_attributes_for :audio_contents, :allow_destroy => true

	alias :authors :users

	before_save :set_type
	before_save :set_published_at
	after_save :populate_encyclical_references
	before_validation :check_clear_attachments

	def check_clear_attachments
		thumbnail.clear if delete_thumbnail == '1'
		image.clear if delete_image == '1'
		homepage_image.clear if delete_homepage_image == '1'
	end

	def reference_name
		nil
	end

	validates :url, :uniqueness => true

	scope :of_type, lambda {|t| where("type = ?", t) }
	scope :thoughts, of_type('Thought')
	scope :no_body, where(:body => '')
	scope :has_body, where("body != ''")
	scope :published, where(:published => true)

	def formatted_published_at
		return unless self.published_at
		self.published_at.strftime("%h %d, %Y %I:%M%P")
	end

	def parsed_body
		self.body
	end

	def parse_encyclical_references
		references = []
		self.body.scan(ContentFragment.encyclical_reference_regex) { |ref, chapter| references << ContentFragment.indexed_encyclical_reference(ref, chapter) }
		references
	end

	def populate_encyclical_references
		self.encyclical_references.destroy_all
		self.body.scan(ContentFragment.encyclical_reference_regex) do |ref, chapter|
			self.encyclical_references << EncyclicalReference.new(:reference => ref, :chapter_number => chapter, :content_fragment_id => self.id)
		end
	end

	def self.indexed_encyclical_reference(ref, chapter)
		"[#{ref},#{chapter}]"
	end

	def self.encyclical_reference_regex
		/\[e:([A-Z]+),(\d+)\]/
	end

	def self.types
		ts = ContentFragment.group(:type).collect { |c| c.type.to_s }.compact
		ts << "Event"
		ts = ts.sort
		ts.delete("Block")
		ts
	end

	def self.users
		includes(:users).collect { |c| c.users }.flatten.uniq
	end

	def menu_items_for_content_fragment
		if !self.url.blank?
			MenuItem.find_all_by_url(self.url)
		else
			[]
		end
	end

	def child_menu_items_for_content_fragment
		self.menu_items_for_content_fragment.map { |mi| mi.children }.flatten.uniq.compact
	end

	private

	def set_type
		self.type = 'ContentFragment' unless self.type
	end

	def set_published_at
		self.published_at = DateTime.now if self.published? and !self.published_at
		self.published_at = nil if !self.published?
	end

end
