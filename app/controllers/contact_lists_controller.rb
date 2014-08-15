class ContactListsController < ApplicationController

	before_filter :require_admin!
	before_filter :load_contact_lists
	before_filter :load_type, :only => [ :by_type, :user_list ]
	layout "mail"

	def by_type
		render :show
	end

	def user_list
		csv_data = CSV.generate do |csv|
			csv << ["Email", "Name"]
			@contact_list.contacts.each do |contact|
				csv << [
					contact.full_name,
					contact.email
				]
			end
		end
		send_data csv_data,
			:type => 'text/csv; charset=iso-8859-1; header=present',
			:disposition => "attachment; filename=#{@contact_list.value_name}_user_list.csv"
	end

	def popup
		@contacts = Contact.search(params[:search]).order(:last_name).paginate(:per_page => 15, :page => params[:page])
		render :popup, :layout => false
	end

	private

	def load_type
		type = params[:type] || "AdminUserList"
		klass = type.constantize
		return render :text => "Error", :status => 404 if klass.table_name != "contact_lists"
		sub_type = params[:sub_type]
		if sub_type
			@contact_list = klass.new(:sub_type => sub_type)
		else
			@contact_list = klass.new
		end
	end
end
