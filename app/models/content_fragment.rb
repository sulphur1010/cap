class ContentFragment < ActiveRecord::Base

	attr_accessor :delete_thumbnail, :delete_image, :delete_homepage_image

	searchable :include => [ :users ] do
		text :title, :stored => true
		text :body, :stored => true
		string :type
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

	alias :authors :users

	before_save :set_type
	before_save :set_published_at
	before_validation :check_clear_attachments

	def check_clear_attachments
		thumbnail.clear if delete_thumbnail == '1'
		 image.clear if delete_image == '1'
		 homepage_image.clear if delete_homepage_image == '1'
	end

	validates :url, :uniqueness => true

	scope :of_type, lambda {|t| where("type = ?", t) }
	scope :thoughts, of_type('Thought')
	scope :no_body, where(:body => '')
	scope :has_body, where("body != ''")
	scope :published, where(:published => true)

	def formatted_published_at
		return unless self.published_at
		self.published_at.strftime("%h %d, %Y %H:%M%P")
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
