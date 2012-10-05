class StaticContactListContact < ActiveRecord::Base
	belongs_to :contact
	belongs_to :static_contact_list
end
