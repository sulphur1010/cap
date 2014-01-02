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
		@audio_content = AudioContent.new
    	3.times {@audio_content.audio_mp3s.build}
		respond_with(@thought = Thought.new)
	end

	def create
		@thought = Thought.new(params[:thought])
		@thought.users << current_user
		@audio_content = AudioContent.new(params[:audio_content])
		if @audio_content.valid?
			@thought.save!	
			@audio_content.content_fragment_id = @thought.id
			@audio_content.save!
			respond_with(@thought, :location => admin_thoughts_url)
		else
			respond_with([@thought, @audio_content], :location => new_admin_thought_url)
		end
	end

	def edit
		@thought = Thought.find(params[:id])
		@audio_content = AudioContent.find_by_content_fragment_id(@thought.id)
		if @audio_content.nil?
    		@audio_content = AudioContent.new
    	end
    	3.times {@audio_content.audio_mp3s.build}
		if @thought.users.include?(current_user) || is_admin?
			respond_with(@thought)
		else
			not_found
		end
	end

	def update
		@thought = Thought.find(params[:id])
		@audio_content = AudioContent.find_by_content_fragment_id(@thought.id)
		if @audio_content.nil?
    		@audio_content = AudioContent.new
    		@audio_content.content_fragment_id = @thought.id
    	end
    	if @audio_content.valid?
			@audio_content.update_attributes(params[:audio_content])
		else
			respond_with([@thought, @audio_content], :location => new_admin_thought_url)
		end

		if @thought.users.include?(current_user) || is_admin?
			respond_with(@thought = Thought.update(params[:id], params[:thought]), :location => thought_path(@thought))
		else
			not_found
		end
	end

	def destroy
		@thought = Thought.find(params[:id])
		@audio_content = AudioContent.find_by_content_fragment_id(@thought.id)
		if !@audio_content == nil?
		    @audio_mp3s = AudioMp3.find_all_by_audio_content_id([@audio_content.id])
		    @audio_mp3s.each do |audio_mp3|
		      audio_mp3.destroy
		    end
		    @audio_content.destroy
		end
	   
		respond_with(@thought = Thought.delete(params[:id]), :location => admin_thoughts_url)
	end

end
