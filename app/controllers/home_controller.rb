class HomeController < ApplicationController
  def index
    @page = Page.where(:url => "/").first
    if @page
      render 'pages/view'
    end
  end
end
