class PagesController < ApplicationController

	respond_to :html

	def view
		url = request.path
		@page = Page.where(:url => request.path).published.first
		if !@page
			not_found
		else
			respond_with(@page)
		end
	end
end
