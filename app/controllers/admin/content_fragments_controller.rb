class Admin::ContentFragmentsController < ApplicationController
	respond_to :html

	def type_options
		cft = params[:content_fragment_type]
		@content_fragments = cft.constantize.order(:title)
		render :action => :type_options, :layout => false
	end

end
