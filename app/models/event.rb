class Event < ActiveRecord::Base
  Event.inheritance_column = :event_type

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
    ["Social Event", "Course", "Private Audience"]
  end

  belongs_to :speaker, :class_name => "User"
  belongs_to :location
  belongs_to :director, :class_name => "User"
  belongs_to :chapter

  has_and_belongs_to_many :contemporary_issues
  has_and_belongs_to_many :person_types

	validates :type, :inclusion => { :in => Event.types }
  validates :end_date, :end_date => true
end
