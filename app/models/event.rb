class Event < ActiveRecord::Base

	def helpers
		ActionController::Base.helpers
	end

	Event.inheritance_column = :event_type_not_used

	scope :past, where("end_date < ?", (Time.now - 1.day)).order(:start_date)
	scope :upcoming, where("end_date >= ?", (Time.now - 1.day)).order(:start_date)
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
		["Conference", "Course", "Lecture", "Retreat", "Communion Breakfast"]
	end

	def self.event_regions
		["International", "USA"]
	end

	belongs_to :location
	belongs_to :director, :class_name => "User"
	belongs_to :chapter

	has_and_belongs_to_many :contemporary_issues
	has_and_belongs_to_many :person_types
	has_and_belongs_to_many :speakers, :class_name => 'User', :association_foreign_key => 'user_id', :join_table => 'events_speakers'
	has_and_belongs_to_many :celebrants, :class_name => 'User', :association_foreign_key => 'user_id', :join_table => 'celebrants_events'
	has_and_belongs_to_many :attendees, :class_name => 'User', :join_table => 'attendees_events', :association_foreign_key => 'attendee_id'

	validates :type, :inclusion => { :in => Event.types }
	validates :event_region, :inclusion => { :in => Event.event_regions }
	validates :title, :presence => true
	validates :end_date, :end_date => true

	def spots_left
		[self.spots_available - self.attendees.count,0].max rescue 0
	end

	def short_start
		return unless self.start_date
		self.start_date.strftime("%h %d, %Y")
	end

	def formatted_start
		return unless self.start_date
		self.start_date.strftime("%l%P - %h %d %Y")
	end

	def formatted_end
		return unless self.end_date
		self.end_date.strftime("%l%P - %h %d %Y")
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
end
