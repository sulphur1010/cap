class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable

	# Setup accessible (or protected) attributes for your model
	attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :title, :phone, :chapter_id, :roles, :person_type_id, :contemporary_issue_ids, :profile_image, :about, :national_board_member, :national_board_weight

	belongs_to :chapter
	belongs_to :person_type
	has_and_belongs_to_many :contemporary_issues
	has_and_belongs_to_many :events, :join_table => 'events_speakers'
	has_and_belongs_to_many :content_fragments;
	has_attached_file :profile_image, :styles => { :small => "80x80>" }
	has_and_belongs_to_many :attended_events, :class_name => 'Event', :join_table => 'attendees_events', :foreign_key => 'attendee_id'

	after_initialize :load_roles
	before_save :convert_roles
	before_save :set_speaker
	before_save :set_celebrant
	before_create :add_user_role

	scope :national_board_members, where(:national_board_member => true).order(:national_board_weight)

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

	def add_user_role
		@roles = [ "user" ]
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
