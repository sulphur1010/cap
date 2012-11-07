class SentEmailMessage < ActiveRecord::Base
	after_initialize :load_to_addresses
	before_save :convert_to_addresses
	before_create :set_initial_status

	belongs_to :user

	attr_accessor :to_addresses

	validates :to, :presence => true, :if => Proc.new { |c| c.status == "queued" }
	validates :subject, :presence => true, :if => Proc.new { |c| c.status == "queued" }
	validates :body, :presence => true, :if => Proc.new { |c| c.status == "queued" }

	scope :queued, where(:status => "queued")
	scope :draft, where(:status => "draft")

	def load_to_addresses
		self.to_addresses = self.to.split(/,/).map { |r| r.strip } rescue []
		unless self.to_addresses
			self.to_addresses = []
		end
	end

	def convert_to_addresses
		self.to = self.to_addresses.map { |r| r.to_s }.join(',')
	end

	def set_initial_status
		self.status = "draft"
	end

	def perform

	end
end
