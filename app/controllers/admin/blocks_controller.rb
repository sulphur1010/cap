class Admin::BlocksController < ApplicationController

	before_filter :require_admin!

	respond_to :html

	def index
		respond_with(@blocks = Block.order(:weight))
	end

	def show
		respond_with(@block => Block.find(params[:id]))
	end

	def new
		respond_with(@block = Block.new)
	end

	def create
		@block = Block.new(params[:block])
		@block.user = current_user
		@block.save!
		respond_with(@block, :location => admin_blocks_url)
	end

	def edit
		respond_with(@block = Block.find(params[:id]))
	end

	def update
		respond_with(@block = Block.update(params[:id], params[:block]), :location => admin_blocks_url)
	end

	def destroy
		respond_with(@block = Block.delete(params[:id]), :location => admin_blocks_url)
	end

end
