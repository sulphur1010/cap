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
		if params[:ids]
			ids = params[:ids].split(",")
			respond_with(@contacts = Contact.delete(ids), :location => admin_contacts_url)
		else
			respond_with(@contact = Contact.delete(params[:id]), :location => admin_contacts_url)
		end
	end

	def show
		respond_with(@contact = Contact.find(params[:id]))
	end

	def edit
		session[:return_url] = params[:return_url] if params[:return_url]
		respond_with(@contact = Contact.find(params[:id]))
	end

	def update
		location = admin_contacts_url
		if session[:return_url]
			location = session[:return_url]
			session.delete(:return_url)
		end
		respond_with(@contact = Contact.update(params[:id], params[:contact]), :location => location)
	end
end
