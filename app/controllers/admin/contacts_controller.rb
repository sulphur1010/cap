class Admin::ContactsController < ApplicationController

	before_filter :require_admin!

	respond_to :html

	def index
		respond_with(@contacts = Contact.order("created_at desc"))
	end

	def raw
		respond_with(@contacts = Contact.order("created_at desc"))
	end

	def destroy
		respond_with(@contact = Contact.delete(params[:id]), :location => admin_contacts_url)
	end
end
