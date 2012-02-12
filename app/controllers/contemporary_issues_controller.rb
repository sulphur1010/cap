class ContemporaryIssuesController < ApplicationController

	before_filter :require_admin!, :except => [ :show ]

  respond_to :html

  def view
    @page = Page.where(:url => "/contemporary_issues/view").first
    unless @page.published
      render :text => "<div class='page'><h2>Page not found</h2></div>", :status => 404, :layout => true
    else
      respond_with(@page)
    end
  end

  def index
    respond_with(@contemporary_issues = ContemporaryIssue.all)
  end

  def show
    @contemporary_issue = ContemporaryIssue.find(params[:id])
    unless @contemporary_issue.published
      not_found
    else
      respond_with(@contemporary_issue)
    end
  end

  def new
    respond_with(@contemporary_issue = ContemporaryIssue.new)
  end

  def create
		@contemporary_issue = ContemporaryIssue.new(params[:contemporary_issue])
		@contemporary_issue.user = current_user
		@contemporary_issue.save!
    respond_with(@contemporary_issue, :location => contemporary_issues_url)
  end

  def edit
    respond_with(@contemporary_issue = ContemporaryIssue.find(params[:id]))
  end

  def update
    respond_with(@contemporary_issue = ContemporaryIssue.update(params[:id], params[:contemporary_issue]), :location => contemporary_issues_url)
  end

  def destroy
    respond_with(@contemporary_issue = ContemporaryIssue.delete(params[:id]), :location => contemporary_issues_url)
  end

end
