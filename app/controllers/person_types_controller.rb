class PersonTypesController < ApplicationController
  respond_to :html

  def index
    respond_with(@person_types = PersonType.order(:weight))
  end

  def show
    respond_with(@person_type = PersonType.find(params[:id]))
  end

  def new
    respond_with(@person_type = PersonType.new)
  end

  def create
    respond_with(@person_type = PersonType.create(params[:person_type]), :location => person_types_url)
  end

  def edit
    respond_with(@person_type = PersonType.find(params[:id]))
  end

  def update
    respond_with(@person_type = PersonType.update(params[:id], params[:person_type]), :location => person_types_url)
  end

  def destroy
    respond_with(@person_type = PersonType.delete(params[:id]), :location => person_types_url)
  end

end
