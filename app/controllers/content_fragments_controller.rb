class ContentFragmentsController < ApplicationController

  respond_to :html

  def index
    respond_with(@content_fragments = ContentFragment.all)
  end

  def page
    url = params[:url]
    @content_fragment = ContentFragment.where(:url => url).first
    if !@content_fragment
      render :file => 'public/404.html', :status => 404, :layout => false
    else
      respond_with(@content_fragment)
    end
  end

  def show
    respond_with(@content_fragment = ContentFragment.find(params[:id]))
  end

  def new
    respond_with(@content_fragment = ContentFragment.new)
  end

  def create
		@content_fragment = ContentFragment.new(params[:content_fragment])
		@content_fragment.user = current_user
		@content_fragment.save
    respond_with(@content_fragment, :location => content_fragments_url)
  end

  def edit
    respond_with(@content_fragment = ContentFragment.find(params[:id]))
  end

  def update
    respond_with(@content_fragment = ContentFragment.update(params[:id], params[:content_fragment]), :location => content_fragments_url)
  end

  def destroy
    respond_with(@content_fragment = ContentFragment.delete(params[:id]), :location => content_fragments_url)
  end

end
