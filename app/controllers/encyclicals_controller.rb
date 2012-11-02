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
		@encyclical_chapters = []
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
		@references = EncyclicalReference.where(:encyclical_id => @encyclical.id).where(:chapter_number => chapter).includes(:content_fragment)
		render :action => :chapter_references, :layout => false
	end

	private

	def index_search(sort)
		sort_order = :asc
		sort_order = :desc if sort == :published_at
		if request.xhr? || params[:q]
			if params[:eq] && params[:eq] != ""
				encyclical_chapter_search(sort, sort_order)
			else
				encyclical_title_search(sort, sort_order)
			end
		end
	end

	def encyclical_chapter_search(sort, sort_order)
		@search = EncyclicalChapter.search do |q|
			if params[:author]
				authors = params[:author].split(/,/)
				if authors.count > 0
					q.with(:author_ids, authors)
				end
			end
			@eq = params[:eq]
			q.fulltext @eq do
				highlight :chapter_body
			end
			#facet_restriction = q.with(:encyclical_id, params[:encyclical_id])
			if params[:encyclical_id]
				encyclical_ids = params[:encyclical_id].split(/,/)
				if encyclical_ids.count > 0
					q.with(:encyclical_id, encyclical_ids)
				end
			end
			q.facet(:encyclical_id)
			q.order_by sort, sort_order
		end
		Rails.logger.debug @search.inspect
		@encyclical_chapters = @search.results
		if request.xhr?
			render :partial => 'chapter_results'#, :collection => @search.hits
			return
		end
	end

	def encyclical_title_search(sort, sort_order)
		@search = ContentFragment.search do |q|
			q.with(:type, 'Encyclical')
			if params[:author]
				authors = params[:author].split(/,/)
				if authors.count > 0
					q.with(:author_ids, authors)
				end
			end
			q.order_by sort, sort_order
		end
		@encyclicals = @search.results
		if request.xhr?
			render :partial => 'teaser', :collection => @encyclicals
			return
		end
	end

	def determine_layout
		return "tinymce_popup" if action_name == "popup"
		"application"
	end
end
