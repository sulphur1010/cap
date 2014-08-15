require 'csv'

class StaticContactListsController < ApplicationController

	before_filter :require_admin!
	before_filter :load_contact_lists
	layout "mail"
	
	def index
	end

	def show
		@contact_list = ContactList.find(params[:id])
	end

	def user_list
		@contact_list = ContactList.find(params[:id])
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

	def new
		@contact_list = StaticContactList.new
	end

	def create
		@contact_list = StaticContactList.create(params[:static_contact_list])
		if @contact_list.save
			redirect_to static_contact_list_path(@contact_list)
		else
			render :new
		end
	end

	def edit
		@contact_list = ContactList.find(params[:id])
	end

	def update
		@contact_list = ContactList.find(params[:id])
		if @contact_list.update_attributes(params[:static_contact_list])
			redirect_to static_contact_list_path(@contact_list)
		else
			render :edit
		end
	end

	def add_contact
		@contact_list = StaticContactList.find(params[:id])
		@contact = Contact.find(params[:contact_id])
		@contact_list.contacts << @contact unless @contact_list.contacts.include?(@contact)
		@contacts = @contact_list.contacts
		render :'show', :layout => false
	end

	def remove_contact
		@contact_list = StaticContactList.find(params[:id])
		contact_ids = params[:contact_ids]
		contact_ids.split(",").each do |contact_id|
			contact = Contact.find(contact_id)
			@contact_list.contacts.delete(contact)
		end
		@contacts = @contact_list.contacts
		render :'show', :layout => false
	end

	def destroy
		@contact_list = ContactList.find(params[:id])
		@contact_list.destroy
		redirect_to static_contact_lists_path
	end
end
