module MailHelper
	def contact_list_href(list)
		if list.class == StaticContactList
			static_contact_list_path(list)
		else
			by_type_contact_lists_path(:type => list.type)
		end
	end
end
