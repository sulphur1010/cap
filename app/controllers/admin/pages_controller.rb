class Admin::PagesController < ApplicationController

	before_filter :require_admin!

	respond_to :html

	def index
		respond_with(@pages = Page.order(:url))
	end

	def show
		respond_with(@page = Page.find(params[:id]))
	end

	def new
		@audio_content = AudioContent.new
    	3.times {@audio_content.audio_mp3s.build}
		respond_with(@page = Page.new)
	end

	def create
		@page = Page.new(params[:page])
		@page.users << current_user
		@audio_content = AudioContent.new(params[:audio_content])
		if @audio_content.valid?
			@page.save!
			@audio_content.content_fragment_id = @page.id
			@audio_content.save!
			respond_with(@page, :location => admin_pages_url)
		else
			respond_with([@page, @audio_content], :location => new_admin_page_url)
		end
	end

	def edit
		@page = Page.find(params[:id])
		@audio_content = AudioContent.find_by_content_fragment_id(@page.id)
		if @audio_content.nil?
    		@audio_content = AudioContent.new
    	end
    	3.times {@audio_content.audio_mp3s.build}
		respond_with(@page)
	end

	def update
		@page = Page.find(params[:id])
		@audio_content = AudioContent.find_by_content_fragment_id(@page.id)
		if @audio_content.nil?
    		@audio_content = AudioContent.new
    		@audio_content.content_fragment_id = @page.id
    	end

    	if @audio_content.valid?
			@audio_content.update_attributes(params[:audio_content])
		else
			respond_with([@page, @audio_content], :location => new_admin_page_url)
		end

		respond_with(@page = Page.update(params[:id], params[:page]), :location => @page.url)
	end

	def destroy
		@page = Page.find(params[:id])
		@audio_content = AudioContent.find_by_content_fragment_id(@page.id)
	    if !@audio_content == nil?
		    @audio_mp3s = AudioMp3.find_all_by_audio_content_id([@audio_content.id])
		    @audio_mp3s.each do |audio_mp3|
		      audio_mp3.destroy
		    end
		    @audio_content.destroy
		end
		respond_with(@page = Page.delete(params[:id]), :location => admin_pages_url)
	end

end
