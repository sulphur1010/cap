class Admin::StoriesController < ApplicationController

	before_filter :require_admin!

	respond_to :html

	def index
		respond_with(@stories = Story.order(:created_at))
	end

	def show
		@story = Story.find(params[:id])
		respond_with(@story)
	end

	def new
		respond_with(@story = Story.new)
	end

	def create
		@story = Story.new(params[:story])
		@story.user = current_user
		@story.save
		respond_with(@story, :location => admin_stories_url)
	end

	def edit
		respond_with(@story = Story.find(params[:id]))
	end

	def update
		respond_with(@story = Story.update(params[:id], params[:story]), :location => admin_stories_url)
	end

	def destroy
		respond_with(@story = Story.delete(params[:id]), :location => admin_stories_url)
	end

end
