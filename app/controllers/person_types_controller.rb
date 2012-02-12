class PersonTypesController < ApplicationController

	before_filter :require_admin!, :except => [ :show ]

  respond_to :html

  def index
    respond_with(@person_types = PersonType.order(:weight))
  end

  def show
    @person_type = PersonType.find(params[:id])
    unless @person_type.published
      not_found
    else
      respond_with(@person_type)
    end
  end

  def new
    respond_with(@person_type = PersonType.new)
  end

  def create
		@person_type = PersonType.new(params[:person_type])
		@person_type.user = current_user
		@person_type.save!
    respond_with(@person_type, :location => person_types_url)
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
