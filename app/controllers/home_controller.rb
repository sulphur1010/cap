class HomeController < ApplicationController
  def index
    @page = Page.where(:url => "/").first
    if @page
      render 'pages/view'
    end
  end

  def what_is_cst
    @page = Page.where(:url => "/what_is_cst").first
  end
end
