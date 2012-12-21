module MailHelper
	def contact_list_href(list)
		if list.class == StaticContactList
			static_contact_list_path(list)
		else
			if list.sub_type
				by_type_contact_lists_path(:type => list.type, :sub_type => list.sub_type)
			else
				by_type_contact_lists_path(:type => list.type)
			end
		end
	end
end
