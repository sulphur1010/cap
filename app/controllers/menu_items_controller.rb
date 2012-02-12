class MenuItemsController < ApplicationController

  before_filter :require_admin!

  respond_to :html

  def index
    respond_with(@menu_items = MenuItem.where(:parent_id => nil).order(:weight))
  end

  def show
    render :text => '', :status => 404
  end

  def new
    respond_with(@menu_item = MenuItem.new)
  end

  def create
    respond_with(@menu_item = MenuItem.create(params[:menu_item]), :location => menu_items_url)
  end

  def edit
    respond_with(@menu_item = MenuItem.find(params[:id]))
  end

  def update
    respond_with(@menu_item = MenuItem.update(params[:id], params[:menu_item]), :location => menu_items_url)
  end

  def destroy
    respond_with(@menu_item = MenuItem.delete(params[:id]), :location => menu_items_url)
  end

end
