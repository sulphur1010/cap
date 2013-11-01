class SentEmailMessagesController < ApplicationController

	before_filter :require_admin!
	before_filter :load_contact_lists
	layout "mail"

	@@not_included_types = [
		"ContemporaryIssue",
		"Encyclical",
		"Page",
		"PapalAddress",
		"PersonType",
		"Principle",
		"PrismType",
		"RoleType"
		]


	def index
		@sent_email_messages = SentEmailMessage.order("updated_at desc")
	end

	def new
		@sent_email_message = SentEmailMessage.draft.where(:user_id => current_user.id).first
		unless @sent_email_message
			@sent_email_message = SentEmailMessage.new(:user_id => current_user.id, :header => "What's New @ CAPP")
			@sent_email_message.save
		end
		@content_fragment_types = ContentFragment.types.select { |cft| !@@not_included_types.include?(cft) }
	end

	def update
		@sent_email_message = SentEmailMessage.find(params[:id])
		@sent_email_message.update_attributes(params[:sent_email_message])
		@sent_email_message.queue!

		if request.xhr?
			render :nothing, :status => 200
		else
			redirect_to sent_email_messages_url
		end
	end

end
