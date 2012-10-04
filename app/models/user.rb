class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable

	def self.about_us_types
		[ "National Board", "Staff", "Chapter President" ]
	end

	# Setup accessible (or protected) attributes for your model
	attr_accessor :delete_profile_image
	attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :title, :phone, :chapter_id, :roles, :person_type_id, :contemporary_issue_ids, :profile_image, :about, :about_us_type, :about_us_weight, :delete_profile_image, :email_list

	belongs_to :chapter
	belongs_to :person_type
	has_and_belongs_to_many :contemporary_issues
	has_and_belongs_to_many :events, :join_table => 'events_speakers'
	has_and_belongs_to_many :content_fragments;
	has_attached_file :profile_image, :styles => { :small => "80x80>" }

	has_many :attendees_events, :foreign_key => :attendee_id
	has_many :attended_events, :through => :attendees_events
	has_many :payment_confirmations

	after_initialize :load_roles
	before_save :set_title
	before_save :convert_roles
	before_save :set_speaker
	before_save :set_celebrant
	before_create :add_user_role
	before_validation :check_clear_attachments
	after_create :send_welcome_email

	validates :first_name, :presence => true
	validates :last_name, :presence => true

	def check_clear_attachments
		profile_image.clear if delete_profile_image == '1'
	end

	scope :national_board_members, where(:about_us_type => 'National Board').order(:about_us_weight)
	scope :staff, where(:about_us_type => 'Staff').order(:about_us_weight)
	scope :chapter_presidents, where(:about_us_type => 'Chapter President').order(:about_us_weight)

	def thoughts
		self.content_fragments.thoughts
	end

	def has_role?(r)
		normalize_roles
		@roles.include?(r) or @roles.include?(r.to_s)
	end

	def roles=(r)
		if r.class == Array
			@roles = r.map { |r| r.to_s }
		else
			@roles = [r.to_s] unless r.to_s.blank?
		end
		normalize_roles
		@roles
	end

	def add_role!(r)
		if r.class == Array
			r.each do |role|
				self.add_role!(role)
			end
		else
			@roles << r.to_s unless r.to_s.blank?
		end
		normalize_roles
		@roles
	end

	def roles
		unless @roles
			@roles = self.role_list.split(/,/).map { |r| r.strip } rescue []
		end
		normalize_roles
		@roles
	end

	def full_name
		if self.first_name.blank? && self.last_name.blank?
			self.email
		else
			"#{self.first_name} #{self.last_name}"
		end
	end

	def encyclicals
		content_fragments.published.of_type("Encyclical")
	end

	private

	def set_title
		self.title = "" if self.title.nil?
	end

	def add_user_role
		@roles = [ "user" ]
	end

	def send_welcome_email
		UserMailer.welcome_email(self).deliver
	end

	def normalize_roles
		@roles = @roles.map { |r| r.to_s }.delete_if { |c| c == "" }.compact
	end

	def load_roles
		@roles = self.role_list.split(/,/).map { |r| r.strip } rescue []
		unless @roles
			@roles = []
		end
	end

	def convert_roles
		self.role_list = @roles.map { |r| r.to_s }.join(',')
	end

	def set_speaker
		self.speaker = @roles.include?("speaker")
		true
	end

	def set_celebrant
		self.celebrant = @roles.include?("celebrant")
		true
	end

end
