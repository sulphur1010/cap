class PrinciplesController < ApplicationController

	before_filter :require_admin!, :except => [ :show ]

  respond_to :html

  def index
    respond_with(@principles = Principle.order(:weight))
  end

  def show
    @principle = Principle.find(params[:id])
    unless @principle.published
      not_found
    else
      respond_with(@principle)
    end
  end

  def new
    respond_with(@principle = Principle.new)
  end

  def create
		@principle = Principle.new(params[:principle])
		@principle.user = current_user
		@principle.save!
    respond_with(@principle, :location => principles_url)
  end

  def edit
    respond_with(@principle = Principle.find(params[:id]))
  end

  def update
    respond_with(@principle = Principle.update(params[:id], params[:principle]), :location => principles_url)
  end

  def destroy
    respond_with(@principle = Principle.delete(params[:id]), :location => principles_url)
  end

end
