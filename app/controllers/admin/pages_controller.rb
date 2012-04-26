class Admin::PagesController < ApplicationController

	before_filter :require_admin!

	respond_to :html

	def index
		respond_with(@pages = Page.all)
	end

	def show
		respond_with(@page = Page.find(params[:id]))
	end

	def new
		respond_with(@page = Page.new)
	end

	def create
		@page = Page.new(params[:page])
		@page.users << current_user
		@page.save!
		respond_with(@page, :location => admin_pages_url)
	end

	def edit
		respond_with(@page = Page.find(params[:id]))
	end

	def update
		respond_with(@page = Page.update(params[:id], params[:page]), :location => admin_pages_url)
	end

	def destroy
		respond_with(@page = Page.delete(params[:id]), :location => admin_pages_url)
	end

end
