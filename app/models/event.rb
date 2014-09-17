class Event < ActiveRecord::Base

	attr_accessor :delete_image

	def self.EVENT_34_PRICE
		return 395
	end

	def self.EVENT_34_OTHER_PRICE
		125
	end

	def self.EVENT_34_GUEST_PRICE
		125
	end

	def self.EVENT_34_DINNER_PRICE
		190
	end

	has_attached_file :image, :styles => { :normal => "720x405" }

	before_save :check_free_event
	after_create :create_reminders!

	attr_accessor :delete_advanced_payment_form
	before_validation :check_clear_attachments

	def check_clear_attachments
		advanced_payment_form.clear if delete_advanced_payment_form == '1'
		image.clear if delete_image == '1'
	end

	def helpers
		ActionController::Base.helpers
	end

	Event.inheritance_column = :event_type_not_used

	scope :past, proc { where("end_date < ?", (Time.now - 1.day)).order(:start_date).reverse_order }
	scope :upcoming, proc { where("end_date >= ?", (Time.now - 1.day)).order(:start_date) }
	scope :course_types, where(:type => "Course").order(:start_date)
	scope :event_types, where("type <> 'Course'").order(:start_date)

	searchable do
		text :title, :stored => true
		text :body, :stored => true
		string :type
	end

	class EndDateValidator < ActiveModel::EachValidator
		def validate_each(record, attribute, value)
			if record.start_date
				if value
					record.errors.add attribute, "must be greater than start date" unless value > record.start_date
				else
					record.errors.add attribute, "must be present if there is a start date"
				end
			end
		end
	end

	def self.types
		["Conference", "Course", "Lecture", "Retreat", "Communion Breakfast", "Gala"]
	end

	def self.attendee_types
		["regular", "clergy", "young_business", "student"]
	end

	def self.event_regions
		["International", "USA"]
	end

	def self.reminder_durations
		[1.week, 1.day]
	end

	def authors
		[ self.director ].compact
	end

	belongs_to :location
	belongs_to :director, :class_name => "User"
	belongs_to :chapter
	has_many :event_reminders
	has_many :payment_confirmations

	has_and_belongs_to_many :contemporary_issues
	has_and_belongs_to_many :person_types
	has_and_belongs_to_many :speakers, :class_name => 'User', :association_foreign_key => 'user_id', :join_table => 'events_speakers'
	has_and_belongs_to_many :celebrants, :class_name => 'User', :association_foreign_key => 'user_id', :join_table => 'celebrants_events'
	has_and_belongs_to_many :related_events, :class_name => 'Event', :association_foreign_key => 'related_event_id', :join_table => 'relateds_events'
	has_many :attendees_events, :include => [ :attendee, :payment_confirmation ]
	has_many :attendees, :through => :attendees_events, :include => [ :payment_confirmations ]
	has_attached_file :advanced_payment_form

	validates :type, :inclusion => { :in => Event.types }
	validates :event_region, :inclusion => { :in => Event.event_regions }
	validates :title, :presence => true
	validates :end_date, :presence => true
	validates :start_date, :presence => true

	def create_reminders!
		Event.reminder_durations.each do |d|
			er = EventReminder.create(:event_id => self.id, :duration => d, :sent => false, :sent_at => nil)
		end
	end

	def spots_left
		count = self.attendees_events.collect { |c| c.count }.inject(:+) || 0
		[self.spots_available - count,0].max rescue 0
	end

	def cost
		cst = self.read_attribute(:cost)
		#return 0 if self.free_event
		cst
	end

	def short_start
		return unless self.start_date
		self.start_date.strftime("%a")
	end
	
	def full_start
		return unless self.start_date
		self.start_date.strftime("%A, %B %d, %Y at %l:%M%P")
	end

	def formatted_start
		return unless self.start_date
		self.start_date.strftime("%A, %B %d, %Y at %l:%M%P")
	end

	def formatted_end
		return unless self.end_date
		self.end_date.strftime("%A, %B %d, %Y at %l:%M%P")
	end

	def duration
		return unless self.end_date && self.start_date
		self.end_date - self.start_date
	end

	def duration_in_words
		if self.end_date && self.start_date && self.end_date.to_date != self.start_date.to_date
			return "#{(self.end_date.to_date - self.start_date.to_date).to_i + 1} days"
		end
		helpers.distance_of_time_in_words(self.end_date, self.start_date, false).sub(/about /, '').sub(/less than /, '')
	end

	# list of users who should be listed in the daily attendees email
	def aggregate_attendees_list(duration=1.day)
		start_time = Time.now - duration
		self.attendees_events.select { |c| c.created_at >= start_time }
	end

	def check_free_event
		if self.cost == ""
			self.cost = 0.0
		end
		if self.cost == 0.0 || self.cost == 0
			if allow_3rd_party_payment == true || allow_other_payment_type == true || allow_paypal == true
				self.free_event = false
			else
				self.free_event = true
			end
		end
		true
	end
end
