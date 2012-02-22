class Event < ActiveRecord::Base
	Event.inheritance_column = :event_type_not_used

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
		["Conference", "Course", "Lecture", "Retreat"]
	end

	def self.event_regions
		["International", "USA"]
	end

	belongs_to :location
	belongs_to :director, :class_name => "User"
	belongs_to :chapter

	has_and_belongs_to_many :contemporary_issues
	has_and_belongs_to_many :person_types
	has_and_belongs_to_many :users

	validates :type, :inclusion => { :in => Event.types }
	validates :event_region, :inclusion => { :in => Event.event_regions }
	validates :title, :presence => true
	validates :end_date, :end_date => true

	def self.upcoming(num = 3)
		Event.where("start_date > ?", Time.now).order(:start_date).limit(num)
	end

	def short_start
		return unless self.start_date
		self.start_date.strftime("%h %d, %Y")
	end

	def formatted_start
		return unless self.start_date
		self.start_date.strftime("%H%P - %h %d %Y")
	end

	def formatted_end
		return unless self.end_date
		self.end_date.strftime("%H%P - %h %d %Y")
	end

	def duration
		return unless self.end_date && self.start_date
		self.end_date - self.start_date
	end
end
