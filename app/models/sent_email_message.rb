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

	def content_fragments
		return [] if self.content_fragment_ids.blank?
		self.content_fragment_ids.split(/,/).map { |cfid|
			cl, id = cfid.split(/:/)
			cl.camelcase.constantize.find(id) rescue nil
		}.flatten.compact.uniq
	end

	def to_addr_str=(str)
		self.to_addresses = str.split(/,/).map { |r| r.strip } rescue []
		self.convert_to_addresses
	end

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
		Rails.logger.info "sending email to #{self.to}"
		self.to_addresses.each do |to_addr|
			UserMailer.delay.bulk_email(self, to_addr)
		end
		self.update_attributes( { :status => "sent" } )
		Rails.logger.info "sent"
	end

	def contact_lists
		ContactList.all_contact_lists.select { |cl| cl.contacts.map(&:email) - self.to_addresses != cl.contacts.map(&:email) }
	end

	def queue!
		return nil unless self.status == "draft"
		self.update_attributes({:status => "queued"})
		Delayed::Job.enqueue(self)
	end
end
