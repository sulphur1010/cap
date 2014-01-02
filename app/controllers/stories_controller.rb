class StoriesController < ApplicationController

	require 'will_paginate/array'
	respond_to :html

	def index
		if request.xhr?
			@stories = Story.published
			@stories += FeedEntry.all
			@stories.flatten!
			if params[:category]
				types = params[:category].split(/,/)
				if types.count > 0
					ews = []
					types.each do |t|
						ews << "category = '#{t}'"
					end
					@stories = Story.published.where(ews.join(" OR "))
					@stories += FeedSource.where(ews.join(" OR ")).collect { |e| e.feed_entries }
					@stories.flatten!
				end
			end
			@stories = @stories.uniq
			@stories = @stories.sort_by(&:published_at).reverse
			render :action => 'ajax_list', :layout => false
			return
		end
		@stories = Story.published
		@stories += FeedEntry.all
		@stories = @stories.sort_by(&:published_at).reverse
		@stories = @stories.paginate(:per_page => 15, :page => params[:page])
		respond_with(@stories)
	end

	def show
		@story = Story.find(params[:id])
		unless @story.published
			not_found
		else
			respond_with(@story)
		end
	end
end
