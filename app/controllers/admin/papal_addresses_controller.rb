class Admin::PapalAddressesController < ApplicationController

	before_filter :require_admin!

	respond_to :html

	def index
		respond_with(@papal_addresses = PapalAddress.order(:weight))
	end

	def show
		@papal_address = PapalAddress.find(params[:id])
		respond_with(@papal_address)
	end

	def new
		respond_with(@papal_address = PapalAddress.new)
	end

	def create
		@papal_address = PapalAddress.new(params[:papal_address])
		@papal_address.users << current_user
		@papal_address.save!
		respond_with(@papal_address, :location => admin_papal_addresses_url)
	end

	def edit
		respond_with(@papal_address = PapalAddress.find(params[:id]))
	end

	def update
		respond_with(@papal_address = PapalAddress.update(params[:id], params[:papal_address]), :location => admin_papal_addresses_url)
	end

	def destroy
		respond_with(@papal_address = PapalAddress.delete(params[:id]), :location => admin_papal_addresses_url)
	end

end
