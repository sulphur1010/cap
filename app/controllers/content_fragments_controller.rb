class ContentFragmentsController < ApplicationController

  respond_to :html

  def index
    respond_with(@content_fragments = ContentFragment.all)
  end

  def show
    respond_with(@content_fragment = ContentFragment.find(params[:id]))
  end

  def new
    respond_with(@content_fragment = ContentFragment.new)
  end

end
