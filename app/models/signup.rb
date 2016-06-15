class Signup < ActiveRecord::Base
	include PayPal::SDK::REST
	attr_protected

	def self.sept_fees
		{:participant => 375, :student => 30, :clergy => 175, :guest => 175, :dinner => 190}
	end

	def self.fees
		if Time.now.to_i < 1473048000
			{:participant => 325, :student => 30, :clergy => 150, :guest => 150, :dinner => 190}
		else
			sept_fees
		end
	end
	
	def fee(type)
		fees[type]
	end

	def self.participant_fee
		fees[:participant]
	end
	
	def self.student_fee
		fees[:student]
	end
	
	def self.dinner_fee
		fees[:dinner]
	end
	
	def self.clergy_fee
		fees[:clergy]
	end
	
	def self.guest_fee
		fees[:guest]
	end
	
	def total
		fees = Signup.fees
		total = fees[self.attendee_type.to_sym]
		if self.accompanied
			total = total + fees[:guest]
			if self.dinner 
				total = total + 2*fees[:dinner]
			end
		else
			if self.dinner 
				total = total + fees[:dinner]
			end
		end
	end
	
	def self.client
		"AYds8Bs42CXtrThrSOgGtxPca5DcljQWfsvMrbCGl8TE-sRCJ-LgsOz3YUqsvOO3qubWTBp-JNUY3vdg"
	end
	
	def self.secret
		"EKhIg5qPVxx51xfnOQIRXj6CStp-sxB0aNc3MAlNaD76L600UM5KykbL5164itFbhebNvg0Uc_5iuqPr"
	end
	
	def name
		first_name + " " + last_name
	end
	
	def self.payment(cc, signup)
		payment = Payment.new({
			:intent => "sale",
			:payer => {
				:payment_method =>"credit_card",

				:funding_instruments => [{
					:credit_card => cc
				}]
			},

			:transactions => [{
				:amount => {
				:total => signup.total,
				:currency => "USD" },
				:description => "Ticket for #{signup.name}" 
			}]
		})
		
		if payment.create
			return true, payment.id
		else
			return false, payment.error
		end
	end
	
	def attendee_type_v
		{:student => "student", :clergy => "Clergy/Religious/Academic/Teacher", :participant => "participant"}[attendee_type.to_sym]
	end
end
