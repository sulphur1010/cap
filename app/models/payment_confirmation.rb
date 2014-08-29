class PaymentConfirmation < ActiveRecord::Base
	belongs_to :attendees_event
	belongs_to :event
	belongs_to :user
	before_save :parse_event_and_user

	def self.acceptible_fields
		[:address_city, :address_country, :address_country_code, :address_name, :address_state, :address_status, :address_street, :address_zip, :business, :charset, :custom, :first_name, :last_name, :invoice, :ipn_track_id, :item_name1, :item_number1, :mc_currency, :mc_fee, :mc_gross_1, :mc_gross, :mc_handling1, :mc_handling, :mc_shipping1, :mc_shipping, :notify_version, :num_cart_items, :payer_email, :payer_id, :payer_status, :payment_date, :payment_fee, :payment_gross, :payment_status, :payment_type, :protection_eligibility, :quantity1, :receiver_email, :receiver_id, :residence_country, :tax, :test_ipn, :transaction_subject, :txn_id, :txn_type, :verify_sign, :created_at, :updated_at, :quantity, :pending_reason, :shipping, :item_name, :item_number, :parent_txn_id, :reason_code, :attendees_event_id, :event_id, :user_id, :item_taxable1, :item_isbn1, :item_plu1, :item_style_number1, :item_tax_rate_double1, :tax1, :item_tax_rate1, :item_count_unit1, :item_mpn1, :item_model_number1, :item_number2, :mc_handling2, :mc_shipping2, :tax2, :item_name2, :quantity2, :mc_gross_2]
	end

	def to_hash
		attributes
	end

	def count
		return 2 if item_name2 == "Guest Registration Fee"
		return 2 if item_name3 == "Guest Registration Fee"
		return 1
	end

	def dinner_count
		return 1 if item_name2 == "Dinner Fee"
		return 0
	end

	private

	def parse_event_and_user
		if self.invoice && !self.attendees_event

			self.attendees_event = AttendeesEvent.new
			self.attendees_event.event = self.event
			self.attendees_event.attendee = self.user if self.user
			self.attendees_event.payment_confirmation = self
			self.attendees_event.payment_method = "paypal"

			self.attendees_event.save
		end
	end
end
