class Admin::EmailAddressesController < ApplicationController

	before_filter :require_admin!

	respond_to :html

	def index
		respond_with(@email_addresses = EmailAddress.order("created_at desc"))
	end

	def raw
		respond_with(@email_addresses = EmailAddress.order("created_at desc"))
	end

	def destroy
		respond_with(@email_address = EmailAddress.delete(params[:id]), :location => admin_email_addresses_url)
	end
end
