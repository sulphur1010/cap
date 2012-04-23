class ContentFragment < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :contemporary_issues
	has_and_belongs_to_many :person_types

	has_attached_file :thumbnail, :styles => { :normal => "175x125>" }
	has_attached_file :image, :styles => { :normal => "680x90>" }

	has_many :encyclical_references
	has_many :encyclicals, :through => :encyclical_references

	alias :author :user

	before_save :set_type
	before_save :set_published_at

	validates :url, :uniqueness => true

	scope :of_type, lambda {|t| where("type = ?", t) }
	scope :thoughts, of_type('Thought')

	def formatted_published_at
		return unless self.published_at
		self.published_at.strftime("%h %d, %Y %H:%M%P")
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
