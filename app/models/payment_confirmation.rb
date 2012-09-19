class PaymentConfirmation < ActiveRecord::Base
	belongs_to :attendees_event
	belongs_to :event
	belongs_to :user
	before_create :parse_event_and_user

	def self.acceptible_fields
		[:address_city, :address_country, :address_country_code, :address_name, :address_state, :address_status, :address_street, :address_zip, :business, :charset, :custom, :first_name, :last_name, :invoice, :ipn_track_id, :item_name1, :item_number1, :mc_currency, :mc_fee, :mc_gross_1, :mc_gross, :mc_handling1, :mc_handling, :mc_shipping1, :mc_shipping, :notify_version, :num_cart_items, :payer_email, :payer_id, :payer_status, :payment_date, :payment_fee, :payment_gross, :payment_status, :payment_type, :protection_eligibility, :quantity1, :receiver_email, :receiver_id, :residence_country, :tax, :test_ipn, :transaction_subject, :txn_id, :txn_type, :verify_sign, :created_at, :updated_at, :quantity, :pending_reason, :shipping, :item_name, :item_number, :parent_txn_id, :reason_code, :attendees_event_id, :event_id, :user_id, :item_taxable1, :item_isbn1, :item_plu1, :item_style_number1, :item_tax_rate_double1, :tax1, :item_tax_rate1, :item_count_unit1, :item_mpn1, :item_model_number1]
	end

	private

	def parse_event_and_user
		data = self.invoice.split("-")
		self.event_id = data.first
		self.user_id = data.last

		ae = AttendeesEvent.where(:attendee_id => data.last).where(:event_id => data.first).first rescue nil

		if !ae
			ae = AttendeesEvent.new
			ae.attendee_id = data.last
			ae.event_id = data.first
			ae.save!
		end
		self.attendees_event = ae
	end
end
