class HomeController < ApplicationController
  def index
    @page = Page.where(:url => "/").first
    if @page
      render 'page/view'
    end
  end
end
