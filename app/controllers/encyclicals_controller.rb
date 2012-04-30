class EncyclicalsController < ApplicationController

	respond_to :html

	def index
		if request.xhr?
			@encyclicals = Encyclical.published.order(:published_at)
			if params[:author]
				authors = params[:author].split(/,/)
				if authors.count > 0
					ews = []
					authors.each do |t|
						ews << "id = '#{t}'"
					end
					users = User.where(ews.join(" OR "))
					@encyclicals = users.collect { |c| c.encyclicals }.flatten.uniq
				end
			end
			render :partial => 'teaser', :collection => @encyclicals
			return
		end
		respond_with(@encyclicals = Encyclical.published.order(:published_at))
	end

	def show
		@encyclical = Encyclical.find(params[:id])
		unless @encyclical.published
			not_found
		else
			respond_with(@encyclical)
		end
	end
end
