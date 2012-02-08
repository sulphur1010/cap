class PrismTypesController < ApplicationController
  respond_to :html

  def index
    respond_with(@prism_types = PrismType.order(:weight))
  end

  def show
    respond_with(@prism_type = PrismType.find(params[:id]))
  end

  def new
    respond_with(@prism_type = PrismType.new)
  end

  def create
    respond_with(@prism_type = PrismType.create(params[:prism_type]), :location => prism_types_url)
  end

  def edit
    respond_with(@prism_type = PrismType.find(params[:id]))
  end

  def update
    respond_with(@prism_type = PrismType.update(params[:id], params[:prism_type]), :location => prism_types_url)
  end

  def destroy
    respond_with(@prism_type = PrismType.delete(params[:id]), :location => prism_types_url)
  end

end
