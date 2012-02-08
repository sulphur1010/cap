class PagesController < ApplicationController

  respond_to :html

  def view
    url = request.path
    @page = Page.where(:url => request.path).first
    if !@page
      render :text => "<div class='page'><h2>Page not found</h2></div>", :status => 404, :layout => true
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
