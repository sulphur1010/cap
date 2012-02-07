class PagesController < ApplicationController

  respond_to :html

  def view
    url = params[:url]
    url = "/#{url}" unless url[0] == '/'
    @page = Page.where(:url => url).first
    if !@page
      render :file => 'public/404.html', :status => 404, :layout => false
    else
      respond_with(@page)
    end
  end

  def index
    respond_with(@pages = Page.all)
  end

  def show
    respond_with(@page = Page.find(params[:id]))
  end

  def new
    respond_with(@page = Page.new)
  end

  def create
    respond_with(@page = Page.create(params[:page]), :location => pages_url)
  end

  def edit
    respond_with(@page = Page.find(params[:id]))
  end

  def update
    respond_with(@page = Page.update(params[:id], params[:page]), :location => pages_url)
  end

  def destroy
    respond_with(@page = Page.delete(params[:id]), :location => pages_url)
  end

end
