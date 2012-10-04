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

	def search
		@encyclicals = Encyclical.published.order(:title).includes(:users)
		index_search(:title)
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

	def chapter_references
		@encyclical = Encyclical.find(params[:id])
		chapter = params[:chapter]
		@search = Sunspot.search([ContentFragment]) do |q|
			q.with(:encyclical_references, ContentFragment.indexed_encyclical_reference(@encyclical.reference_keyword, chapter))
		end
		@results = @search.results
		render :action => :chapter_references, :layout => false
	end

	private

	def index_search(sort)
		sort_order = :asc
		sort_order = :desc if sort == :published_at
		if request.xhr? || params[:q]
			@search = ContentFragment.search do |q|
				q.with(:type, 'Encyclical')
				if params[:author]
					authors = params[:author].split(/,/)
					if authors.count > 0
						q.with(:author_ids, authors)
					end
				end
				if params[:eq]
					@eq = params[:eq]
					q.fulltext @eq #do
						#highlight :body
					#end
				end
				q.order_by sort, sort_order
			end
			@encyclicals = @search.results
			if request.xhr?
				render :partial => 'teaser', :collection => @encyclicals
				return
			end
		end
	end

	def determine_layout
		return "tinymce_popup" if action_name == "popup"
		"application"
	end
end
