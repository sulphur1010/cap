class ContemporaryIssuesController < ApplicationController

	respond_to :html

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

	def view
		@contemporary_issue = ContemporaryIssue.find(params[:id])
		unless @contemporary_issue.published
			not_found
		else
			respond_with(@contemporary_issue)
		end
	end

end
