class Admin::ContemporaryIssuesController < ApplicationController

	before_filter :require_admin!

	respond_to :html

	def index
		respond_with(@contemporary_issues = ContemporaryIssue.all.order(:title))
	end

	def show
		@contemporary_issue = ContemporaryIssue.find(params[:id])
		respond_with(@contemporary_issue)
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
		respond_with(@contemporary_issue = ContemporaryIssue.update(params[:id], params[:contemporary_issue]), :location => admin_contemporary_issues_url)
	end

	def destroy
		respond_with(@contemporary_issue = ContemporaryIssue.delete(params[:id]), :location => admin_contemporary_issues_url)
	end

end
