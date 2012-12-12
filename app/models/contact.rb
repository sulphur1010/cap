class Contact < ActiveRecord::Base
	validates :email, :presence => true, 
						:length => { :minimum => 3, :maximum => 254 },
						:uniqueness => true,
						:format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}

	US_STATES = [["Alaska", "AK"], ["Alabama", "AL"], ["Arkansas", "AR"], ["Arizona", "AZ"], 
							 ["California", "CA"], ["Colorado", "CO"], ["Connecticut", "CT"], ["District of Columbia", "DC"], 
							 ["Delaware", "DE"], ["Florida", "FL"], ["Georgia", "GA"], ["Hawaii", "HI"], ["Iowa", "IA"], 
							 ["Idaho", "ID"], ["Illinois", "IL"], ["Indiana", "IN"], ["Kansas", "KS"], ["Kentucky", "KY"], 
							 ["Louisiana", "LA"], ["Massachusetts", "MA"], ["Maryland", "MD"], ["Maine", "ME"], ["Michigan", "MI"], 
							 ["Minnesota", "MN"], ["Missouri", "MO"], ["Mississippi", "MS"], ["Montana", "MT"], ["North Carolina", "NC"], 
							 ["North Dakota", "ND"], ["Nebraska", "NE"], ["New Hampshire", "NH"], ["New Jersey", "NJ"], 
							 ["New Mexico", "NM"], ["Nevada", "NV"], ["New York", "NY"], ["Ohio", "OH"], ["Oklahoma", "OK"], 
							 ["Oregon", "OR"], ["Pennsylvania", "PA"], ["Rhode Island", "RI"], ["South Carolina", "SC"], ["South Dakota", "SD"], 
							 ["Tennessee", "TN"], ["Texas", "TX"], ["Utah", "UT"], ["Virginia", "VA"], ["Vermont", "VT"], 
							 ["Washington", "WA"], ["Wisconsin", "WI"], ["West Virginia", "WV"], ["Wyoming", "WY"]] unless const_defined?("US_STATES")

	NAME_PREFIXES = [
							"Ms",
							"Miss",
							"Mrs",
							"Mr",
							"Master",
							"Rev",
							"Fr",
							"Dr",
							"Atty",
							"Prof",
							"Hon",
							"Pres",
							"Gov",
							"Coach",
							"Ofc" ] unless const_defined?("NAME_PREFIXES")

	def full_name
		if self.first_name.blank? && self.last_name.blank?
			self.email
		else
			"#{self.first_name} #{self.last_name}"
		end
	end

	def self.search(search)
		if search
			where('first_name LIKE ? OR last_name LIKE ? OR email LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
		else
			scoped
		end
	end
end
