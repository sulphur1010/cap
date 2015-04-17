class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable

	def self.affiliation_types
		[
			[ "National Board", "national_board" ],
			[ "Staff", "staff" ],
			[ "Chapter Covernors", "chapter_covernors" ],
			[ "Advisor", "advisor_" ],
			[ "Ecces. Advisor", "ecces_advisor" ],
			[ "Council", "council" ],
			[ "Chaplain", "chaplain" ],
			[ "Chapter FC", "chapter_fc" ],
			[ "Chapter NK", "chapter_nk" ],
			[ "Chapter DC", "chapter_dc" ],
			[ "Member", "member" ]
		]
	end

	def self.roles
		[
			["Admin", "admin"],
			["Speaker", "speaker"],
			["Celebrant", "celebrant"],
			["Thought Creator", "thought_creator"],
			["Account Holder", "user" ]
		]
	end

	def self.roles_map
		map = {}
		User.roles.each do |data|
			map[data[1]] = data[0]
		end
		map
	end

	# Setup accessible (or protected) attributes for your model
	attr_accessor :delete_profile_image
	attr_accessible :email, :password, :password_confirmation, :remember_me, :home_phone, :work_phone, :chapter_id, :roles, :person_type_id, :contemporary_issue_ids, :profile_image, :about, :affiliations, :about_us_weight, :delete_profile_image, :email_list, :contact_attributes, :first_name, :last_name, :title

	belongs_to :chapter
	belongs_to :person_type
	has_and_belongs_to_many :contemporary_issues
	has_and_belongs_to_many :events, :join_table => 'events_speakers'
	has_and_belongs_to_many :content_fragments;
	has_attached_file :profile_image, :styles => { :small => "80x80>" }

	has_one :contact, :foreign_key => :email, :primary_key => :email, :autosave => true
	accepts_nested_attributes_for :contact

	has_many :attendees_events, :foreign_key => :attendee_id
	has_many :attended_events, :through => :attendees_events
	has_many :payment_confirmations

	has_many :static_contact_lists

	after_initialize :load_roles
	after_initialize :load_affiliations
	before_save :set_title
	before_save :convert_roles
	before_save :convert_affiliations
	before_save :set_speaker
	before_save :set_celebrant
	before_save :update_contact_email
	before_create :add_user_role
	before_validation :check_clear_attachments
	#after_create :send_welcome_email

	def check_clear_attachments
		profile_image.clear if delete_profile_image == '1'
	end

	scope :national_board_members, where("affiliation_list LIKE '%national_board%'")
	scope :staff, where("affiliation_list LIKE '%staff%'")
	scope :chapter_presidents, where("affiliation_list LIKE '%chapter_president%'")
	scope :advisors, where("affiliation_list LIKE '%advisor_%'")
	scope :ecces_advisors, where("affiliation_list LIKE '%ecces_advisor%'")
	scope :council, where("affiliation_list LIKE '%council%'")
	scope :chaplains, where("affiliation_list LIKE '%chaplain%'")
	scope :chapter_fc_account_holders, where("affiliation_list LIKE '%chapter_fc%'")
	scope :chapter_nk_account_holders, where("affiliation_list LIKE '%chapter_nk%'")
	scope :chapter_dc_account_holders, where("affiliation_list LIKE '%chapter_dc%'")
	scope :members, where("affiliation_list LIKE '%member%'")

	scope :admins, where("role_list LIKE '%admin%'")
	scope :speakers, where("role_list LIKE '%speaker%'")
	scope :thought_creators, where("role_list LIKE '%thought_creator%'")
	scope :celebrants, where("role_list LIKE '%celebrant%'")

	scope :by_last_name, joins(:contact).order("contacts.last_name")

	def first_name
		self.contact.first_name rescue nil
	end

	def last_name
		self.contact.last_name rescue nil
	end

	def first_name=(fn)
		c = self.mandatory_contact
		c.first_name = fn
		fn
	end

	def last_name=(ln)
		c = self.mandatory_contact
		c.last_name = ln
		ln
	end

	def home_phone=(p)
		c = self.mandatory_contact
		c.home_phone = p
		p
	end

	def work_phone=(p)
		c = self.mandatory_contact
		c.work_phone = p
		p
	end

	def title=(t)
		c = self.mandatory_contact
		c.title = t
		t
	end

	def roles_display
		map = User.roles_map
		self.roles.collect { |c|
			map[c]
		}
	end

	def mandatory_contact
		unless self.contact
			self.create_contact
		else
			self.contact
		end
	end

	def title
		self.contact.title rescue nil
	end

	def home_phone
		self.contact.home_phone rescue nil
	end

	def work_phone
		self.contact.work_phone rescue nil
	end

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

	def affiliations=(r)
		if r.class == Array
			@affiliations = r.map { |r| r.to_s }
		else
			@affiliations = [r.to_s] unless r.to_s.blank?
		end
		normalize_affiliations
		@affiliations
	end

	def affiliations
		unless @affiliations
			@affiliations = self.affiliation_list.split(/,/).map { |r| r.strip } rescue []
		end
		normalize_affiliations
		@affiliations
	end

	def full_name
		if self.first_name.blank? && self.last_name.blank?
			self.email
		else
			"#{self.first_name} #{self.last_name}"
		end
	end

	def full_name_last_name_first
		if self.first_name.blank? && self.last_name.blank?
			self.email
		else
			"#{self.last_name}, #{self.first_name}"
		end
	end
	

	def encyclicals
		content_fragments.published.of_type("Encyclical")
	end

	def account_holder?
		true
	end

	def user
		self
	end

	# we need to ensure we update the correct contact if the email changes
	def contact_attributes=(attributes)
		c = self.contact
		if self.email_changed?
			c = Contact.where(:email => self.email_change[0]).first
		end
		if c
			c.update_attributes(attributes)
		end
	end

	private

	def save_contact_if_dirty!
		if self.contact && (self.contact.changed? || self.contact.new_record?)
			self.contact.save
		end
	end

	def set_title
		self.title = "" if self.title.nil? && !self.contact.nil?
	end

	def update_contact_email
		return unless self.email_changed?
		contact = Contact.where(:email => self.email_change[0]).first
		if contact
			contact.email = self.email_change[1]
			contact.save!
		end
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

	def normalize_affiliations
		@affiliations = @affiliations.map { |r| r.to_s }.delete_if { |c| c == "" }.compact
	end

	def load_roles
		@roles = self.role_list.split(/,/).map { |r| r.strip } rescue []
		unless @roles
			@roles = []
		end
	end

	def load_affiliations
		@affiliations = self.affiliation_list.split(/,/).map { |r| r.strip } rescue []
		unless @affiliations
			@affiliations = []
		end
	end

	def convert_roles
		self.role_list = @roles.map { |r| r.to_s }.join(',')
	end

	def convert_affiliations
		self.affiliation_list = @affiliations.map { |r| r.to_s }.join(',')
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
