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
		@audio_content = AudioContent.new
    	3.times {@audio_content.audio_mp3s.build}
		respond_with(@story = Story.new)
	end

	def create
		@story = Story.new(params[:story])
		@story.users << current_user
		@audio_content = AudioContent.new(params[:audio_content])
		if @audio_content.valid?
			@story.save
			@audio_content.content_fragment_id = @story.id
			@audio_content.save
			respond_with(@story, :location => admin_stories_url)
		else
			respond_with([@story, @audio_content], :location => new_admin_story_url)
		end
	end

	def edit
		@story = Story.find(params[:id])
		@audio_content = AudioContent.find_by_content_fragment_id(@story.id)
		if @audio_content.nil?
    		@audio_content = AudioContent.new
    	end
    	3.times {@audio_content.audio_mp3s.build}
		respond_with(@story)
	end

	def update
		@story = Story.find(params[:id])
		@audio_content = AudioContent.find_by_content_fragment_id(@story.id)
		if @audio_content.nil?
    		@audio_content = AudioContent.new
    		@audio_content.content_fragment_id = @story.id
    	end
    	if @audio_content.valid?
			@audio_content.update_attributes(params[:audio_content])
		else
			respond_with([@story, @audio_content], :location => new_admin_story_url)
		end

		respond_with(@story = Story.update(params[:id], params[:story]), :location => story_path(@story))
	end

	def destroy
		@story = Story.find(params[:id])
		@audio_content = AudioContent.find_by_content_fragment_id(@story.id)
	    if !@audio_content == nil?
		    @audio_mp3s = AudioMp3.find_all_by_audio_content_id([@audio_content.id])
		    @audio_mp3s.each do |audio_mp3|
		      audio_mp3.destroy
		    end
		    @audio_content.destroy
		end

		respond_with(@story = Story.delete(params[:id]), :location => admin_stories_url)
	end

end
