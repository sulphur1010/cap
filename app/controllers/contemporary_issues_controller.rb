class ContemporaryIssuesController < ApplicationController

	respond_to :html

	before_filter :load_contemporary_issues

	def index
		@page = Page.where(:url => "/contemporary_issues").first
		respond_with(@contemporary_issues)
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

	private

	def load_contemporary_issues
		@person_type = PersonType.find(params[:q]) rescue nil
		@contemporary_issues = @person_type.contemporary_issues.published.sort_by(&:title) rescue ContemporaryIssue.published.sort_by(&:title)
	end

end
