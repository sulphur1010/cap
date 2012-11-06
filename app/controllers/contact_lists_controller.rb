class ContactListsController < ApplicationController

	before_filter :load_contact_lists
	layout "mail"

	def by_type
		type = params[:type]
		klass = type.constantize
		return render :text => "Error", :status => 404 if klass.table_name != "contact_lists"
		@contact_list = klass.new
		render :show
	end
end
