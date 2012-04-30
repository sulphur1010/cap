class SearchController < ApplicationController

	respond_to :html

	def index
		@q = ''
		@type = [ "All" ]
		@type = params["type"].split(",") if params["type"]
		@type = [ "All" ] if @type.size == 0
		@q = params["q"] if params["q"]
		Rails.logger.info "Searching with q = #{@q}"
		@search = Sunspot.search([ContentFragment, Event]) do |q|
			q.fulltext @q do
				highlight :body
			end
			q.without(:type, 'Block')
			if !@type.include?("All")
				q.with(:type, @type)
			end
		end
		@results = @search.results
		if request.xhr?
			if @search.hits.empty?
				render :partial => 'no_results'
			else
				render :partial => 'result', :collection => @search.hits
			end
			return
		end
	end
end
