class EncyclicalsController < ApplicationController

	respond_to :html
	layout :determine_layout

	def index
		@encyclicals = Encyclical.published.order(:title).includes(:users)
		index_search(:title)
	end

	def published
		@encyclicals = Encyclical.published.order("published_at desc").includes(:users)
		index_search(:published_at)
		if !request.xhr?
			render :action => :index
		end
	end

	def show
		@encyclical = Encyclical.find(params[:id])
		unless @encyclical.published
			not_found
		else
			respond_with(@encyclical)
		end
	end

	def popup
		@encyclicals = Encyclical.published.order(:title)
	end

	def reference
		@encyclical = Encyclical.find(params[:id])
		render :action => :reference, :layout => false
	end

	private

	def index_search(sort)
		if request.xhr?
			if params[:author]
				authors = params[:author].split(/,/)
				if authors.count > 0
					ews = []
					authors.each do |t|
						ews << "id = '#{t}'"
					end
					users = User.where(ews.join(" OR "))

					# user.encyclical only returns published, so this is safe
					@encyclicals = users.collect { |c| c.encyclicals }.flatten.uniq
					@encyclicals = @encyclicals.sort_by(&sort)
					if sort.to_s == "published_at"
						@encyclicals.reverse!
					end
				end
			end
			render :partial => 'teaser', :collection => @encyclicals
			return
		end
	end

	def determine_layout
		return "tinymce_popup" if action_name == "popup"
		"application"
	end
end
