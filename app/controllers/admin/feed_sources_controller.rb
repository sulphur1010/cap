class Admin::FeedSourcesController < ApplicationController

	before_filter :require_admin!

	respond_to :html

	def index
		respond_with(@feed_sources = FeedSource.order(:title))
	end

	def show
		respond_with(@feed_source = FeedSource.find(params[:id]))
	end

	def new
		respond_with(@feed_source = FeedSource.new)
	end

	def create
		respond_with(@feed_source = FeedSource.create(params[:feed_source]), :location => admin_feed_sources_url)
	end

	def edit
		respond_with(@feed_source = FeedSource.find(params[:id]))
	end

	def update
		@feed_source = FeedSource.update(params[:id], params[:feed_source])
		respond_with(@feed_source , :location => admin_feed_source_path(@feed_source))
	end

	def destroy
		respond_with(@feed_source = FeedSource.delete(params[:id]), :location => admin_feed_sources_url)
	end
end
