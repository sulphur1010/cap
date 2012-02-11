class ThoughtsController < ApplicationController

	before_filter :require_admin!, :except => [ :show ]

	respond_to :html

	def index
		respond_with(@thoughts = Thought.order(:weight))
	end

	def show
		@thought = Thought.find(params[:id])
		unless @thought.published
			not_found
		else
			respond_with(@thought)
		end
	end

	def new
		respond_with(@thought = Thought.new)
	end

	def create
		respond_with(@thought = Thought.create(params[:thought]), :location => thoughts_url)
	end

	def edit
		respond_with(@thought = Thought.find(params[:id]))
	end

	def update
		respond_with(@thought = Thought.update(params[:id], params[:thought]), :location => thoughts_url)
	end

	def destroy
		respond_with(@thought = Thought.delete(params[:id]), :location => thoughts_url)
	end

end
