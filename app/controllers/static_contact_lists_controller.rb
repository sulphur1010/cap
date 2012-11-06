class StaticContactListsController < ApplicationController

	before_filter :load_contact_lists
	layout "mail"

	def show
		@contact_list = ContactList.find(params[:id])
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
end
