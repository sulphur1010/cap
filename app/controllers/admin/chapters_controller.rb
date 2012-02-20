class Admin::ChaptersController < ApplicationController
	before_filter :require_admin!

	respond_to :html

	def index
		respond_with(@chapters = Chapter.order(:name))
	end

	def show
		@chapter = Chapter.find(params[:id])
		respond_with(@chapter)
	end

	def new
		respond_with(@chapter = Chapter.new)
	end

	def create
		respond_with(@chapter = Chapter.create(params[:chapter]), :location => admin_chapters_url)
	end

	def edit
		respond_with(@chapter = Chapter.find(params[:id]))
	end

	def update
		respond_with(@chapter = Chapter.update(params[:id], params[:chapter]), :location => admin_chapters_url)
	end

	def destroy
		respond_with(@chapter = Chapter.delete(params[:id]), :location => admin_chapters_url)
	end

end
