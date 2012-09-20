class StoriesController < ApplicationController

	respond_to :html

	def index
		if request.xhr?
			@stories = Story.published.order("created_at desc")
			if params[:category]
				types = params[:category].split(/,/)
				if types.count > 0
					ews = []
					types.each do |t|
						ews << "category = '#{t}'"
					end
					@stories = @stories.where(ews.join(" OR "))
				end
			end
			@stories = @stories.uniq
			render :action => 'ajax_list', :layout => false
			return
		end
		@stories = Story.published.order("created_at desc")
		@stories += FeedEntry.all
		@stories = @stories.sort_by(&:created_at).reverse
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
