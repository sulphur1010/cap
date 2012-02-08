class RoleTypesController < ApplicationController
  respond_to :html

  def index
    respond_with(@role_types = RoleType.order(:weight))
  end

  def show
    respond_with(@role_type = RoleType.find(params[:id]))
  end

  def new
    respond_with(@role_type = RoleType.new)
  end

  def create
    respond_with(@role_type = RoleType.create(params[:role_type]), :location => role_types_url)
  end

  def edit
    respond_with(@role_type = RoleType.find(params[:id]))
  end

  def update
    respond_with(@role_type = RoleType.update(params[:id], params[:role_type]), :location => role_types_url)
  end

  def destroy
    respond_with(@role_type = RoleType.delete(params[:id]), :location => role_types_url)
  end

end
