class StoriesController < ApplicationController
	before_filter :require_admin!, :except => [ :show ]

	respond_to :html

	def index
		respond_with(@stories = Story.order(:created_at))
	end

	def show
		@story = Story.find(params[:id])
		unless @story.published
			not_found
		else
			respond_with(@story)
		end
	end

	def new
		respond_with(@story = Story.new)
	end

	def create
		@story = Story.new(params[:story])
		@story.user = current_user
		@story.save
		respond_with(@story, :location => stories_url)
	end

	def edit
		respond_with(@story = Story.find(params[:id]))
	end

	def update
		respond_with(@story = Story.update(params[:id], params[:story]), :location => stories_url)
	end

	def destroy
		respond_with(@story = Story.delete(params[:id]), :location => stories_url)
	end

end
