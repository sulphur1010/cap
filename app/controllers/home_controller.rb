class HomeController < ApplicationController
	def index
		@page = Page.where(:url => "/").first
		if @page
			render 'pages/view'
		end
	end

	def what_is_cst
		@page = Page.where(:url => "/what_is_cst").first
	end

	def study_center
		@page = Page.where(:url => '/study_center').first
	end
end
