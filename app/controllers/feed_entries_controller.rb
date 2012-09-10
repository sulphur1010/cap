class FeedEntriesController < ApplicationController

	respond_to :html

	def show
		@feed_entry = FeedEntry.find(params[:id])
		#unless @feed_entry.published
		#	not_found
		#else
			respond_with(@feed_entry)
		#end
	end
end
