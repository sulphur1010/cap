class ContentFragment < ActiveRecord::Base

	searchable :include => [ :user ] do
		text :title, :stored => true
		text :body, :stored => true
		string :type
	end

	has_and_belongs_to_many :users
	has_and_belongs_to_many :contemporary_issues
	has_and_belongs_to_many :person_types

	has_attached_file :thumbnail, :styles => { :normal => "175x125>" }
	has_attached_file :image, :styles => { :normal => "680x90>" }

	has_many :encyclical_references
	has_many :encyclicals, :through => :encyclical_references
	has_many :questions

	alias :authors :users

	before_save :set_type
	before_save :set_published_at

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
		types = ContentFragment.group(:type).collect { |c| c.type }
		types << "Event"
		types = types.sort
		types.delete("Block")
		types
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
