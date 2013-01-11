class ContactListsController < ApplicationController

	before_filter :require_admin!
	before_filter :load_contact_lists
	layout "mail"

	def by_type
		type = params[:type]
		klass = type.constantize
		return render :text => "Error", :status => 404 if klass.table_name != "contact_lists"
		sub_type = params[:sub_type]
		if sub_type
			@contact_list = klass.new(:sub_type => sub_type)
		else
			@contact_list = klass.new
		end
		render :show
	end

	def popup
		@contacts = Contact.search(params[:search]).order(:last_name).paginate(:per_page => 15, :page => params[:page])
		render :popup, :layout => false
	end
end
