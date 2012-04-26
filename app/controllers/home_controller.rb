class HomeController < ApplicationController
	def index
		@page = Page.where(:url => "/").first
		@show_right_side_bar = false
	end

	def what_is_cst
		@page = Page.where(:url => "/what_is_cst").first
	end

	def study_center
		@page = Page.where(:url => '/study_center').first
	end

	def about_us_national_board
		@page = Page.where(:url => '/about_us/national_board').first
	end
end
