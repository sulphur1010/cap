class Admin::PrinciplesController < ApplicationController

	before_filter :require_admin!

	respond_to :html

	def index
		respond_with(@principles = Principle.order(:weight))
	end

	def show
		@principle = Principle.find(params[:id])
		respond_with(@principle)
	end

	def new
		respond_with(@principle = Principle.new)
	end

	def create
		@principle = Principle.new(params[:principle])
		@principle.users << current_user
		@principle.save!
		respond_with(@principle, :location => admin_principles_url)
	end

	def edit
		respond_with(@principle = Principle.find(params[:id]))
	end

	def update
		respond_with(@principle = Principle.update(params[:id], params[:principle]), :location => admin_principles_url)
	end

	def destroy
		respond_with(@principle = Principle.delete(params[:id]), :location => admin_principles_url)
	end

end
