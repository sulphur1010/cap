class Admin::ThoughtsController < ApplicationController

	before_filter :require_thought_creator!

	respond_to :html

	def index
		if is_admin?
			@thoughts = Thought.order(:weight)
		else
			@thoughts = current_user.thoughts.order(:weight)
		end
		respond_with(@thoughts)
	end

	def show
		@thought = Thought.find(params[:id])
		respond_with(@thought)
	end

	def new
		respond_with(@thought = Thought.new)
	end

	def create
		@thought = Thought.new(params[:thought])
		@thought.user = current_user
		@thought.save!
		respond_with(@thought, :location => admin_thoughts_url)
	end

	def edit
		@thought = Thought.find(params[:id])
		if @thought.user == current_user || is_admin?
			respond_with(@thought)
		else
			not_found
		end
	end

	def update
		@thought = Thought.find(params[:id])
		if @thought.user == current_user || is_admin?
			respond_with(@thought = Thought.update(params[:id], params[:thought]), :location => admin_thoughts_url)
		else
			not_found
		end
	end

	def destroy
		respond_with(@thought = Thought.delete(params[:id]), :location => admin_thoughts_url)
	end

end
