class PapalAddressesController < ApplicationController

	respond_to :html

	def index
		respond_with(@papal_addresses = PapalAddress.published)
	end

	def show
		@papal_address = PapalAddress.find(params[:id])
		unless @papal_address.published
			not_found
		else
			respond_with(@papal_address)
		end
	end

end
