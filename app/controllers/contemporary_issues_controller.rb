class ContemporaryIssuesController < ApplicationController
  respond_to :html

  def index
    respond_with(@contemporary_issues = ContemporaryIssue.all)
  end

  def show
    respond_with(@contemporary_issue = ContemporaryIssue.find(params[:id]))
  end

  def new
    respond_with(@contemporary_issue = ContemporaryIssue.new)
  end

  def create
    respond_with(@contemporary_issue = ContemporaryIssue.create(params[:contemporary_issue]), :location => contemporary_issues_url)
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
